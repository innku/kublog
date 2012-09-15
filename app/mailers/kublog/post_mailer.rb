module Kublog
  class PostMailer < ActionMailer::Base
        
    def new_post(notification, user)
      @notification, @post, @user = notification, notification.post, user
      mail(:to => @user.email, :subject => @notification.title, :from => Kublog.email_from(@notification.post))
    end
    
  end
end
