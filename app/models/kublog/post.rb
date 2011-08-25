# encoding: UTF-8
module Kublog
  class Post < ActiveRecord::Base
    extend FriendlyId
    include Notification::Email, Notification::Tweet, Notification::FbPost
    
    #Associations
    belongs_to                :user
    belongs_to                :category
    has_many                  :comments, :dependent => :destroy
    
    validates_presence_of     :title, :body, :user
    validate                  :body_with_content
    
    #Special Attributes
    serialize                 :intended_for, Array
    friendly_id               :title, :use => :slugged
    
    #Scopes
    default_scope             order('kublog_posts.created_at DESC')
    
    def author
      user.to_s
    end
    
    def to_s
      title
    end
    
    # Public Access to the Post
    def url
      Engine.routes.url_helpers.quickie_url(self, :host => Kublog.default_url_options[:host])
    end
    
    def related_posts
      self.category.posts.where('id != ?', self.id) unless self.category.nil?
    end
    
    private
    
    def body_with_content
      errors.add(:body, :blank) if blank_body?
    end
    
    # Weird regex identifies &nbsp; generated blank chars
    def blank_body?
      Sanitize.clean(self.body).gsub(/[ | ]/, '').blank? 
    end
    
  end
end