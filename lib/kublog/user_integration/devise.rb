module Kublog
  module UserIntegration
    module Devise
      
      def self.included(base)
        base.send :include, InstanceMethods
        base.send :helper_method,:is_admin?
      end
      
      module InstanceMethods
        
        # Uses the already defined current_user method by Devise
        # get the admin? value to filter out publishing actions
        
        def is_admin?
          current_user && current_user.try(:admin?)
        end
        
      end
      
    end
  end
end