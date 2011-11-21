module Kublog
  class CommentMailer < ActionMailer::Base
    
    def new_comment(comment)
      @comment, @post = comment, comment.post
      subject = I18n.t('kublog.comment_mailer.new_comment.subject', :post => @post.title)
      mail(:to => @post.user.email, :subject => subject, :from => @comment.email)
    end

  end
end
