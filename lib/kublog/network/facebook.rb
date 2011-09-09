module Kublog
  module Network
    module Facebook
      
      def self.included(base)        
        base.send :include, InstanceMethods
        base.send :validate, :valid_facebook_content, :if => :facebook?
      end
      
      module InstanceMethods
        
        # Calls the appropriate processor on create callback
        # Posts on the fan page wall a link to the post        
        def deliver_facebook
          Processor.work(WallPost.new(self.url, self.content))
        end
        
        # Defaults to create a facebook wall post when creating a post
        # off by default when editing a post
        def default_facebook
          post.new_record?
        end
        
        # Returns true when notification acts as facebook notification
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
        
        # Posts a link to the post with the title of the content of the notification
        # as a default message
        def perform
          Kublog.facebook_client.link! :link => @url, :message => @message
        end
        
      end
      
    end
  end
end