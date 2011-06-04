class ApplicationController < ActionController::Base
  protect_from_forgery

  #filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user
    
  layout :layout_by_resource

  def layout_by_resource
    if devise_controller?
      "user"
    else
      "application"
    end
  end


  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to account_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end
      
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def format_date_remove_zeroes(date_to_format)  
    date_num= date_to_format.strftime('%d').to_i
    month_num = date_to_format.strftime('%m').to_i
    formatted_date=date_num.to_s+"/"+month_num.to_s         
  end

end
