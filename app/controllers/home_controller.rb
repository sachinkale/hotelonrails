class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => ['index','add_service','add_payment','delete_service','delete_payment','get_checkin','send_report','rooms','split_room']
  def index
    @rooms = Room.paginate :page => params[:page],:order => "id"
    @home = true
  end

  def login
    respond_to do |format|
      format.html { render :layout => "user" }
    end
    
  end

  def add_service
    @service_item = ServiceItem.new(params[:service_item])
    if @service_item.save!
      respond_to do |format|
        format.html { redirect_to "/checkins"}
        format.js
      end
    end
  end

  def add_payment
    @payment = Payment.new(params[:payment])
    if @payment.save!
      respond_to do |format|
        format.html { redirect_to "/checkins" }
        format.js
      end
    end
  end

  def delete_service
    @service_item = ServiceItem.find(params[:delete_service_item_id])
    @checkin = @service_item.checkin
    @service_item.destroy
    respond_to do |format|
      format.js
    end
  end

  def delete_payment

  end

  def getcheckin
    @checkin = Checkin.find(params[:id].sub(/room-\d+-checkin-/,''))
    respond_to do |format|
      format.js
    end

  end


  def send_report
    @checkins = Checkin.where("created_at > '#{Date.today - 1}'")
    ReportMailer.daily_report(@checkins).deliver
    render :text => "ok"
  end

  def rooms
    #@rooms = Room.paginate :page => params[:page], :order => 'created_at DESC'
    respond_to do |format|
      format.js
    end
  end

  def split_room
    line_item = LineItem.find(params[:splitroom_line_item_id].sub(/\D+/,''))
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
    respond_to do |format|
      format.html {
        flash[:notice] = "Splitted Room as a new checkin successfully"
        redirect_to :action => "index"
      }
    end
  end

end
