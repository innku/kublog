# Class configured to Notify via DelayedJob
module Kublog
  module Notification
    class TweetJob    
          
      def initialize(tweet, post)
        @tweet, @post = tweet, post
      end
  
      def perform
        Post.safe_twitter_update(@tweet, @post)
      end      
      
    end
  end
end