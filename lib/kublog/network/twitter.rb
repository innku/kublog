module Kublog
  module Network
    module Twitter
      
      def self.included(base)        
        base.send :include,  InstanceMethods
        base.send :validate, :valid_twitter_content, :if => :twitter?
      end
  
      module InstanceMethods
        def deliver_twitter
          Processor.work(Tweet.new(self.content, self.url))
        end
    
        def default_twitter
          post.new_record?
        end
        
        def twitter?
          self.kind == 'twitter'
        end
        
        private
        
        def valid_twitter_content
          errors.add(:content, :twitter) if self.content.blank?
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