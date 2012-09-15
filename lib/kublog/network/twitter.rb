module Kublog
  module Network
    module Twitter
      
      def self.included(base)        
        base.send :include,  InstanceMethods
        base.send :validate, :valid_twitter_content, :if => :twitter?
      end
  
      module InstanceMethods
        
        # Calls processor to work on delivering the tweet
        def deliver_twitter
          Processor.work(Tweet, self.id)
        end
        
        # It's activated by default when a new post is created
        # but not when editing the post
        def default_twitter
          post.new_record?
        end
        
        # Returns true when the notification behaves like a twitter
        # notification
        def twitter?
          self.kind == 'twitter'
        end
        
        private
        
        # Not valid when tweet content is empty
        def valid_twitter_content
          errors.add(:content, :twitter) if self.content.blank?
        end
        
      end
          
      class Tweet
        @queue = :kublog_notifications
    
        def self.perform(notification_id)
          notification = Kublog::Notification.find(notification_id)
          content, url = notification.content, notification.url
          update = [content, url].join(' ')
          Kublog.twitter_client.update(update)
        end    

      end
    end
  end
end
