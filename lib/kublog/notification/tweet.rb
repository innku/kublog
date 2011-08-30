# Includes functionality to send to twitter on after_create callback

module Kublog
  module Notification
    module Tweet
      
      def self.included(base)
        base.send :attr_accessor, :twitter_notify, :tweet_text
        
        base.send :include,       InstanceMethods
        base.send :extend,        ClassMethods
        
        base.send :include, case Kublog.notification_processing.try(:to_sym)
          when :delayed_job then DelayedJob
          else Immediate
        end
        
        base.send :after_create,  :notify_tweet
        base.send :validates_presence_of, :tweet_text, :if => :twitter_notify
        base.send :before_validation, :really_notify_twitter?
      end
      
      module InstanceMethods
        
        protected
        
        def notify_tweet
          if self.twitter_notify 
            self.twitter_notify = nil
            tweet_deliver([self.tweet_text, self.url].join(' '))
          end
        end
        
        def really_notify_twitter?
          self.twitter_notify = nil if self.twitter_notify.to_i.zero?
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
          nil # Dont do anything for now
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
        Post.safe_twitter_update(tweet, self)
      end
    end
    
  end
end