module Kublog
  module Network
    module Facebook
      
      def self.included(base)        
        base.send :include, InstanceMethods
        base.send :validate, :valid_facebook_content, :if => :facebook?
      end
      
      module InstanceMethods
                
        def deliver_facebook
          Processor.work(WallPost.new(self.url, self.content))
        end
        
        def default_facebook
          post.new_record?
        end
        
        def facebook?
          self.kind == 'facebook'
        end
        
        private
        
        def valid_facebook_content
          errors.add(:content, :facebook) if self.content.blank?
        end
        
      end
      
      class WallPost
        
        def initialize(url, message)
          @url = url
          @message = message
        end
        
        def perform
          Kublog.facebook_client.link! :link => @url, :message => @message
        end
        
      end
      
    end
  end
end