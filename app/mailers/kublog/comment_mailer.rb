module Kublog
  class CommentMailer < ActionMailer::Base
    
    def new_comment(comment)
      @comment, @post = comment, comment.post
      comment_observers = CommentMailerManager.comment_observers_emails(@comment)
      subject = I18n.t('kublog.comment_mailer.new_comment.subject', :post => @post.title)
      mail(:to => comment_observers, :subject => subject, :from => @comment.email)
    end

  end
end
