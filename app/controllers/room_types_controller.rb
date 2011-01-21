class RoomTypesController < ApplicationController
  before_filter :authenticate_admin!
  # GET /room_types
  # GET /room_types.xml
  def index
    @room_types = RoomType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @room_types }
    end
  end

  # GET /room_types/1
  # GET /room_types/1.xml
  def show
    @room_type = RoomType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @room_type }
    end
  end

  # GET /room_types/new
  # GET /room_types/new.xml
  def new
    @room_type = RoomType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @room_type }
    end
  end

  # GET /room_types/1/edit
  def edit
    @room_type = RoomType.find(params[:id])
  end

  # POST /room_types
  # POST /room_types.xml
  def create
    @room_type = RoomType.new(params[:room_type])

    respond_to do |format|
      if @room_type.save
        format.html { redirect_to(@room_type, :notice => 'Room type was successfully created.') }
        format.xml  { render :xml => @room_type, :status => :created, :location => @room_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @room_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /room_types/1
  # PUT /room_types/1.xml
  def update
    @room_type = RoomType.find(params[:id])

    respond_to do |format|
      if @room_type.update_attributes(params[:room_type])
        format.html { redirect_to(@room_type, :notice => 'Room type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @room_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /room_types/1
  # DELETE /room_types/1.xml
  def destroy
    @room_type = RoomType.find(params[:id])
    @room_type.destroy

    respond_to do |format|
      format.html { redirect_to(room_types_url) }
      format.xml  { head :ok }
    end
  end
end
