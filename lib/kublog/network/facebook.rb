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
          Processor.work(WallPost, self.id)
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
        @queue = :kublog_notifications
        
        def self.perform(notification_id)
          notification = Kublog::Notification.find(notification_id)
          message, url = notification.content, notification.url
          Kublog.facebook_client.link! :link => url, :message => message
        end
        
      end
      
    end
  end
end
