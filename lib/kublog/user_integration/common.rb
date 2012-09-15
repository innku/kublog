module Kublog
  module UserIntegration
    module Common
      
      def self.included(base)
        base.send :include, InstanceMethods
        base.send :helper_method, :kublog_current_user, :is_admin?, :signed_in?
      end
      
      module InstanceMethods
        # Uses session[:user_id] to get the user session
        # should be able to change user for x name of model
        def kublog_current_user
          @kublog_current_user ||= User.find_by_id(session[:user_id])
        end

        # Tries admin? method for user to filter out publishing actions
        def is_admin?
          kublog_current_user && kublog_current_user.try(:admin?)
        end
        
        ## Sign in helper method
        def signed_in?
          !!kublog_current_user
        end
        
      end
      
    end
  end
end
