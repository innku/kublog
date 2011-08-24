# Includes functionality to send to twitter on after_create callback

module Kublog
  module Notification
    module Tweet
      
      def self.included(base)
        base.send :include,       InstanceMethods
        base.send :extend,        ClassMethods
        
        base.send :include, case Kublog.notification_processing.try(:to_sym)
          when :delayed_job then DelayedJob
          else Immediate
        end
        
        base.send :after_create,  :notify_tweet
        base.send :validates_presence_of, :tweet_text, :if => :twitter_notify
      end
      
      module InstanceMethods
        
        protected
        
        def notify_tweet
          if self.twitter_notify 
            tweet_deliver([self.tweet_text, self.url].join(' '))
          end
        end
        
      end
    end
    
    module ClassMethods
      
      # TODO Find out more about Twitter::NotFound()
      # Configure whether or not to send errors
      def safe_twitter_update(update, post)
        begin
          return Kublog.twitter_client.update(update)
        rescue Twitter::NotFound
          latest_tweet = Kublog.twitter_client.user_timeline.first
          if latest_tweet.text.gsub(/ http:\/\/[^ ]\Z/, '') == post.tweet_text
            return latest_tweet
          else
            return {:id => nil, :text => post.tweet_text}
          end
        end
      end
      
    end
    
    # Queues Process on DJ
    module DelayedJob
      def tweet_deliver(tweet)
        Delayed::Job.enqueue(TweetJob.new(tweet, self)) 
      end
    end

    # Delivers Immediately
    module Immediate
      def tweet_deliver(tweet)
        response = safe_twitter_update(tweet, self)
        self.update_attributes :tweet_id => response.id, :tweet_text => response.text
      end
    end
    
  end
end