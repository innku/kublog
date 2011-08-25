module Kublog
  module UserIntegration
    module Common
      
      def self.included(base)
        base.send :include, InstanceMethods
        base.send :helper_method, :current_user, :is_admin?
      end
      
      module InstanceMethods
        
        # Uses session[:user_id] to get the user session
        # should be able to change user for x name of model
        def current_user
          @current_user ||= User.find_by_id(session[:user_id])
        end

        # Tries admin? method for user to filter out publishing actions
        def is_admin?
          current_user && current_user.try(:admin?)
        end
        
      end
      
    end
  end
end