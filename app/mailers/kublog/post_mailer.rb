module Kublog
  class PostMailer < ActionMailer::Base
    default from: "test@kublog.com"
    
    def new_post(post, user)
      @post, @user = post, user
      mail(:to => user.email, :subject => post.title.titleize)
    end
    
  end
end
