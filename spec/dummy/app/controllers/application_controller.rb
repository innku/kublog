class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def kublog_current_user
    @kublog_current_user ||= User.find_by_id(session[:user_id])
  end
  
  def signed_in?
    !!kublog_current_user
  end
  
  helper_method :kublog_current_user, :signed_in?
  
  def kublog_current_user=(user)
    @kublog_current_user = user
    session[:user_id] = user.id
  end

end
