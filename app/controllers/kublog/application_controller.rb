module Kublog
  class ApplicationController < ActionController::Base
    
    before_filter :require_admin
    helper_method :is_admin?
    
    def require_admin
      redirect_to root_path unless is_admin?
    end
    
    def is_admin?
      false
    end
    
  end
end
