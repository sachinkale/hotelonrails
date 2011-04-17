class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => ['index']


  def index
    @rooms = Room.paginate :page => params[:page],:order => "id"
    @rooms_available = Room.available
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


  

end
