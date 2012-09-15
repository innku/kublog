module Kublog
  class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :post
    
    validates_presence_of :body
    validate              :has_user_details
    
    default_scope   order('kublog_comments.created_at ASC')
    delegate        :admin?, :to => :user, :allow_nil => true
    
    after_create    :notify_author
    
    def author
      (self.user && self.user.to_s) || self.author_name
    end
    
    def as_json(args={})
      args ||= {}
      super(args.merge!({:methods => [:path, :author, :ftime, :admin?]}))
    end
    
    def path
      Engine.routes.url_helpers.post_comment_path(self.post, self)
    end
    
    def ftime
      I18n.l(self.created_at, :format => :short)
    end
    
    def email
      author_email || user.email
    end
    
    private
    
    def notify_author
      if CommentMailerManager.necessary_notifications?(self)
        Processor.work(DeliverComment.new(self.id))
      end
    end
    
    def has_user_details
      if self.user.nil?
        errors.add(:author_name,  :blank) if author_name.blank?
        errors.add(:author_email, :blank) if author_email.blank?
        errors.add(:author_email, :invalid) if !valid_author_email?
      end
    end
    
    def valid_author_email?
      self.author_email.to_s.match(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i)
    end
    
  end
end
