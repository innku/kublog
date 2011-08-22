# Class configured to Notify via DelayedJob
module Kublog
  module Notification
    class FbPostJob    
          
      def initialize(elements={})
        @elements = elements
      end
  
      def perform
        Kublog.facebook_client.link!(@elements)
      end      
      
    end
  end
end