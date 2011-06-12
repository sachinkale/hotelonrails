class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => ['index']
  before_filter :authenticate_admin!,:only => ['admin']

  def index
    @rooms = Room.paginate :page => params[:page],:order => "id"
    @rooms_available = Room.available
    @room_checkin = Hash.new
    Checkin.where("status is NULL").each do |c|
      c.line_items.each do |li|
        if not li.freez 
          @room_checkin[li.room] = c
        end
      end
    end

  end

  def login

    respond_to do |format|
      format.html { 
        if user_signed_in?
          redirect_to user_root_path
        else
          render :layout => "user" 
        end
      }
    end
    
  end

  def send_report
    ct = Checkin.arel
    @checkins = Checkin.where(ct["created_at"].gteq(Date.today - 1.day)).or(ct["status"].eq(nil))
    ReportMailer.daily_report(@checkins).deliver
    render :text => "ok"
  end

  def pie_chart_data
    @o_rooms = Room.where("status is NOT NULL and status like '%check%'").length
    @un_rooms = Room.where("status is NULL").length
    @m_rooms = Room.all.length - @o_rooms - @un_rooms
  end

  def bar_chart_data
    ct = Checkin.arel_table
    startdate = Date.new
    e = Date.new
    if params[:date] and params[:date] != "undefined" and (Date.parse(params[:date]).beginning_of_week() - 1.day < Time.now.beginning_of_week().to_date)
      startdate = Date.parse(params[:date]).beginning_of_week()
      enddate = Date.parse(params[:date]).end_of_week()
      @checkins = Checkin.where(ct[:fromdate].gteq(startdate)).where(ct[:todate].lteq(enddate))
      @checkins.concat Checkin.where(ct[:fromdate].gteq(startdate)).where(ct[:status].eq(nil))
      e = enddate
    else
      startdate =  Time.now.beginning_of_week().to_date
      @checkins = Checkin.where(ct[:fromdate].gteq(startdate - 1.day).or(ct[:status].eq(nil)))
      e = Date.today
    end
    #@date_revenue = Hash.new
    @date_revenue = ActiveSupport::OrderedHash.new
    t = startdate
    while t <= e
      @date_revenue[t.to_time.strftime("%d/%m")] = Array.new
      @date_revenue[t.to_time.strftime("%d/%m")][0] = 0
      @date_revenue[t.to_time.strftime("%d/%m")][1] = 0
      @date_revenue[t.to_time.strftime("%d/%m")][2] = 0
      @checkins.each do |c|
        arr = c.revenue_for_day(t)
        @date_revenue[t.to_time.strftime("%d/%m")][0] += arr[0]
        @date_revenue[t.to_time.strftime("%d/%m")][1] += arr[1]
        @date_revenue[t.to_time.strftime("%d/%m")][2] += arr[2]
      end
      t = t + 1.day
    end

  end

  
  def admin


  end

end
