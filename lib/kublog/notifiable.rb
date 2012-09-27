# Module to be included in User if it wants to implement notifications
# Sets class options to see if the user has required the module
# And defaults notification for every user to true

module Kublog
  module Notifiable
    
    def self.included(base)
      base.send :include, InstanceMethods
    end
    
    # Defaults notification setting to true
    # If User Kinds are being used, this should be
    # Overriden
    module InstanceMethods
      def notify_post?(roles)
        true
      end
    end
    
  end
end