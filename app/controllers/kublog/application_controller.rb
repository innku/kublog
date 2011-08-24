module Kublog
  class ApplicationController < ActionController::Base
    
    before_filter :require_admin
    
    # Set to override this method if using alternative
    # Authentication strategies
    def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end
    
    def signed_in?
      !!current_user
    end
    
    def is_admin?
      current_user && current_user.try(:admin?)
    end
    
    helper_method :current_user, :signed_in?, :is_admin?
    
    def require_admin
      redirect_to root_path unless is_admin?
    end
    
  end
end
