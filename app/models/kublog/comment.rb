module Kublog
  class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :post
    
    validates_presence_of :body
    validate              :has_user_details
    
    def author
      return self.author_name if self.user.nil?
      return self.user.to_s
    end
    
    # Site access to the category
    def path
      Engine.routes.url_helpers.post_comment_path(self.post, self)
    end
    
    def as_json(options={})
      super(options.merge({:methods => [:path, :author]}))
    end
    
    private
    
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
