module Kublog
  class ApplicationController < ActionController::Base
    
    before_filter :require_admin
    
    # Set to override this method if using alternative
    # Authentication strategies
    def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end
    
    helper_method :current_user
    
    def require_admin
      redirect_to root_path unless current_user.admin?
    end
    
  end
end
