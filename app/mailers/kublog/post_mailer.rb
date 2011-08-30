module Kublog
  class PostMailer < ActionMailer::Base
        
    def new_post(post, user)
      @post, @user = post, user
      mail(:to => user.email, :subject => post.title.titleize, :from => Kublog.email_from(post))
    end
    
  end
end
