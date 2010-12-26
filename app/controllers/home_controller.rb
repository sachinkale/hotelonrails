class HomeController < ApplicationController
  def index
    @rooms = Room.paginate :page => params[:page],:order => "id"
    @home = true
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

  def my_add_payment

  end

  def my_add_service

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

end
