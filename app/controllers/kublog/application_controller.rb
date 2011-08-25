module Kublog
  class ApplicationController < ActionController::Base
    include UserIntegration::Common
    
    before_filter :require_admin
    
    def require_admin
      redirect_to root_path unless is_admin?
    end
    
  end
end
