module Kublog
  class PostMailer < ActionMailer::Base
        
    def new_post(email, user)
      @email, @post, @user = email, email.post, user
      mail(:to => @user.email, :subject => @post.title.titleize, :from => Kublog.email_from(@post))
    end
    
  end
end
