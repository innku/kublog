# Includes functionality to send to twitter on after_create callback

module Kublog
  module Network
    module Twitter
      
      def self.included(base)        
        base.send :include, InstanceMethods
      end
  
      module InstanceMethods
        def deliver_twitter
          Processor.work(Tweet.new(self.content, self.url))
        end
    
        def default_twitter
          post.new_record?
        end
      end
          
      class Tweet
        def initialize(content, url)
          @content = content
          @url = url
        end
    
        def perform
          begin
            update = [@content, @url].join(' ')
            Kublog.twitter_client.update(update)
          rescue Twitter::NotFound
            nil # Dont do anything for now
          end
        end
        
      end
    end
  end
end