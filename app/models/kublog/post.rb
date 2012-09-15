# encoding: UTF-8
module Kublog
  class Post < ActiveRecord::Base
    extend FriendlyId
    
    #Associations
    belongs_to                :user,          :polymorphic => true
    belongs_to                :category
    has_many                  :comments,      :dependent => :destroy
    has_many                  :notifications, :dependent => :nullify
    has_one                   :invited_author, :dependent => :destroy
    
    validates_presence_of     :title, :body, :user
    validate                  :body_with_content
    
    #Special Attributes
    friendly_id               :title, :use => :slugged
    attr_accessor             :want_invited_author
    
    #Scopes
    default_scope             order('kublog_posts.created_at DESC')
    
    accepts_nested_attributes_for :notifications
    accepts_nested_attributes_for :invited_author

    after_update              :check_for_deleted_invited_author
    
    def author
      invited_author ? invited_author : user
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
    
    def check_for_deleted_invited_author
      invited_author.delete if invited_author && !want_invited_author
    end
  end
end
