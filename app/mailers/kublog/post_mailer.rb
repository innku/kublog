module Kublog
  class PostMailer < ActionMailer::Base
        
    def new_post(email, post, user)
      @email, @post, @user = email, post, user
      mail(:to => @user.email, :subject => @email.subject, :from => Kublog.email_from(@email.post))
    end
    
  end
end
