module Kublog
  class PostMailer < ActionMailer::Base
        
    def new_post(email, user)
      @email, @user = email, user
      mail(:to => @user.email, :subject => @email.subject, :from => Kublog.email_from(@email.post))
    end
    
  end
end
