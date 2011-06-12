class RoomsController < ApplicationController
 before_filter :authenticate_admin!, :only => ['new','edit','create','update','destroy']

  # GET /rooms
  # GET /rooms.xml
  def index
    @rooms = Room.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rooms }
    end
  end

  # GET /rooms/1
  # GET /rooms/1.xml
  def show
    @room = Room.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @room }
    end
  end

  # GET /rooms/new
  # GET /rooms/new.xml
  def new
    @room = Room.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @room }
    end
  end

  # GET /rooms/1/edit
  def edit
    @room = Room.find(params[:id])
  end

  # POST /rooms
  # POST /rooms.xml
  def create
    @room = Room.new(params[:room])

    respond_to do |format|
      if @room.save
        format.html { redirect_to(@room, :notice => 'Room was successfully created.') }
        format.xml  { render :xml => @room, :status => :created, :location => @room }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @room.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rooms/1
  # PUT /rooms/1.xml
  def update
    @room = Room.find(params[:id])

    respond_to do |format|
      if @room.update_attributes(params[:room])
        format.html { redirect_to(@room, :notice => 'Room was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @room.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.xml
  def destroy
    @room = Room.find(params[:id])
    @room.destroy

    respond_to do |format|
      format.html { redirect_to(rooms_url) }
      format.xml  { head :ok }
    end
  end

  def block_room
    if params[:block_room_id] != ""
      room = Room.find(params[:block_room_id])
      room.update_attribute('status',"blocked-#{params[:reason]}")
      notice = "Room Blocked Successfully"
    else
      notice = "Please select Room to block!"
    end
    respond_to do |format|
      format.html {
        redirect_to(root_url, :notice => notice)
      }
    end

  end
  def unblock_room
    if params[:unblock_room_id] != ""
      room = Room.find(params[:unblock_room_id])
      room.update_attribute('status',nil)
      notice = "Room UnBlocked Successfully"
    else
      notice = "Please select Room to unblock!"
    end
    respond_to do |format|
      format.html {
        redirect_to(root_url, :notice => notice)
      }
    end

  end



end
