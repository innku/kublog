# encoding: UTF-8
module Kublog
  class Post < ActiveRecord::Base
    extend FriendlyId
    
    #Associations
    belongs_to                :user,          :class_name => Kublog.author_class
    belongs_to                :category
    has_many                  :comments,      :dependent => :destroy
    has_many                  :notifications, :dependent => :nullify
    
    validates_presence_of     :title, :body, :user
    validate                  :body_with_content
    
    #Special Attributes
    friendly_id               :title, :use => :slugged
    
    #Scopes
    default_scope             order('kublog_posts.created_at DESC')
    
    accepts_nested_attributes_for :notifications
    
    def author
      user.to_s
    end
    
    def to_s
      title
    end
    
    # Public Access to the Post
    def url
      unless new_record?
        Engine.routes.url_helpers.quickie_url(self, :host => Kublog.default_url_options[:host])
      end
    end
    
    def related_posts
      unless self.category.nil?
        self.category.posts.where('id != ?', self.id)
      end
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