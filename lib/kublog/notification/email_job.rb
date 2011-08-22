# Class configured to Notify via DelayedJob
module Kublog
  module Notification
    class EmailJob        
      def initialize(post, user)
        @post, @user = post, user
      end
  
      def perform
        PostMailer.new_post(@post, @user).deliver
      end      
    end
  end
end