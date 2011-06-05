class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => ['index']


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
    @checkins = Checkin.where("created_at > '#{Date.today - 1}'")
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
    @checkins = Checkin.where(ct[:fromdate].gteq(Time.now.beginning_of_week().to_date - 1.day).or(ct[:status].eq(nil)))
    @date_revenue = Hash.new
    t = Date.today
    while t > Time.now.beginning_of_week().to_date
      @date_revenue[t.to_time.strftime("%d/%m")] = 0
      @checkins.each do |c|
        amtd = c.revenue_for_day(t)
        @date_revenue[t.to_time.strftime("%d/%m")] += amtd
      end
      t = t - 1.day
    end

  end

  

end
