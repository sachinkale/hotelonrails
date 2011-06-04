class CheckinsController < ApplicationController
  before_filter :authenticate_user!

  # GET /checkins
  # GET /checkins.xml
  def index
    #@checkins = Checkin.where("status is NULL")

    @checkins = Checkin.paginate :page => params[:page],:order => "updated_at desc"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @checkins }
    end
  end

  # GET /checkins/1
  # GET /checkins/1.xml
  def show
    @checkin = Checkin.find(params[:id])

    respond_to do |format|
      format.js
      format.html # show.html.erb
      format.xml  { render :xml => @checkin }
    end
  end

  # GET /checkins/new
  # GET /checkins/new.xml
  def new
    @checkin = Checkin.new
    @rooms = Room.where("status is NULL");
    @company = Company.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @checkin }
    end
  end

  # GET /checkins/1/edit
  def edit
    @checkin = Checkin.find(params[:id])
    @checkin.status = "Checked Out"
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /checkins
  # POST /checkins.xml
  def create
    @checkin = Checkin.new(params[:checkin])
    respond_to do |format|
      if not params[:guest].nil?
        if @checkin.save 
          params[:payment][:checkin_id] = @checkin.id

          if(params[:payment][:amount] != 0 or params[:payment][:amount] != "")
            @payment = Payment.new(params[:payment])
            @payment.save!
          end
          checkin_time = ""
          1.upto(Room.all.length) do |i|
            if not params["room#{i.to_s}"].nil?
              room = Room.find(params["room#{i.to_s}"][:room_id])
              if room.status.nil?
                params["room#{i.to_s}"][:checkin_id] = @checkin.id
                params["room#{i.to_s}"]["tax"] = 0 if params["room#{i.to_s}"]["tax"] == ""
                params["room#{i.to_s}"]["rate"] = 0 if params["room#{i.to_s}"]["rate"] == ""
                params["room#{i.to_s}"]["extraperson"] = 0 if params["room#{i.to_s}"]["extraperson"] == ""
                t = Time.now.in_time_zone
                d = DateTime.parse(params["room#{i.to_s}"][:fromdate] + "T" + t.hour.to_s + ":" + t.min.to_s)
                params["room#{i.to_s}"][:fromdate] = d.to_s
                line_item = LineItem.new(params["room#{i.to_s}"])
                line_item.save!
                checkin_time = d.to_s
              else
                @checkin.destroy
                format.html { redirect_to(new_checkin_path, :notice => "Room #{room.number} is already checked in") }
                format.xml  { render :xml => @checkin.errors, :status => :unprocessable_entity }
              end
            end
          end
          @checkin.update_fromdate
          params[:guest].each do |key,value|
            arr = value.split(/#/)
            guest = Guest.new
            if arr[0] != "" || arr[1] != ""
              guest.FirstName = arr[0]
              guest.LastName = arr[1]
              guest.save!
              @checkin.guests << guest
            end
          end
          format.html { redirect_to(user_root_url, :notice => 'Checkin was successfully created.') }
          format.xml  { render :xml => @checkin, :status => :created, :location => @checkin }


        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @checkin.errors, :status => :unprocessable_entity }
        end
      else
          format.html { redirect_to :action => "new",:notice => "Please add guests" }
      end
 

    end
  end

  # PUT /checkins/1
  # PUT /checkins/1.xml
  def update
    @checkin = Checkin.find(params[:id])
    params[:checkin][:description] =  params[:select_description] + " : " + params[:checkin][:description] 
    respond_to do |format|
      if @checkin.update_attributes(params[:checkin])
        @checkin.checkout if not @checkin.status.nil?
        format.html { redirect_to(user_root_url, :notice => 'Checkin was successfully updated.') }
        format.js { }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @checkin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /checkins/1
  # DELETE /checkins/1.xml
  def destroy
    @checkin = Checkin.find(params[:id])
    @checkin.destroy

    respond_to do |format|
      format.html { redirect_to(checkins_url) }
      format.xml  { head :ok }
    end
  end

  def checkout
    @checkin = Checkin.find(params[:id])
    @title = "Print Invoice"
    respond_to do |format|
      format.html { render :layout => "print"}
    end
  end
 
  def split_room
    line_item = LineItem.find(params[:splitroom_line_item_id].sub(/\D+/,'').to_i)
    flag = 0
    if line_item.freez
      flag = 1
    else
      checkin = Checkin.new
      checkin.company = line_item.checkin.company if not line_item.checkin.company.nil?
      checkin.save!
      checkin.guests << line_item.checkin.guests
      line_item.checkin.service_items.each do |si|
        if si.room_id == line_item.room_id
          si.checkin = checkin
          si.save!
        end
      end
      line_item.checkin = checkin
      line_item.save!
      checkin.update_fromdate
    end
    respond_to do |format|
      format.html {
        if flag == 1
          flash[:notice] = "Cannot Split Room as the room is shifted"
        else
          flash[:notice] = "Splitted Room as a new checkin successfully"
        end
        redirect_to user_root_url
      }
    end
  end

  def shift_room

    myarr = params[:shiftroom_room_id_checkin_id].split(/-/)
    from_room = Room.find(myarr[1])
    checkin = Checkin.find(myarr[3])
    to_room = Room.find(params[:shift_room_id])
    line_item = LineItem.where("checkin_id = ? and room_id = ?",checkin.id,from_room.id).first

    if params[:rate] == ""
      rate = to_room.room_type.base_rate
    else
      rate = params[:rate].to_i
    end
    
    if params[:tax] == ""
      tax = 0
    else 
      tax = params[:tax]
    end

    if line_item.no_of_days > 1 
      line_item.update_attributes(:todate => Time.now, :freez => true)
      new_line_item = LineItem.create({:room_id => to_room.id, :fromdate => Time.now, :checkin_id => checkin.id, :extraperson => line_item.extraperson, :tax => line_item.tax, :rate => rate})
    else
      line_item.update_attribute(:room_id,to_room.id)
      line_item.update_attribute(:rate,rate)
      line_item.update_attribute(:tax,tax.to_f)
    end

    from_room.update_attribute('status',nil)
    to_room.update_attribute('status','blocked - checked in')

    respond_to do |format|
      format.html {
        flash[:notice] = "Shifted Room successfully!"
        redirect_to user_root_url
      }
    end


  end

  
end
