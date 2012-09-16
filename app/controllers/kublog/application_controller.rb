module Kublog
  class ApplicationController < ActionController::Base
    before_filter :require_admin
    
    helper_method :is_admin?
    helper_method :current_user #TODO: Delete me if you're using Devise
    
    def require_admin
      redirect_to root_path unless is_admin?
    end
    
    ## TODO: Fill in this method
    ## This method should return the logged in user or nil
    ## Define this whether or not you have it on your application controller
    ## Apps using Devise can skip this
    def current_user

    end
    
    ## TODO: Fill in this method
    ## Returns if the current user has admin privileges for the blog
    ## Define this whether or not you have the method on your application controller
    def is_admin?
      true
    end
    
  end
end
