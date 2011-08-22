module Kublog
  class Post < ActiveRecord::Base
    extend FriendlyId
    include Notification::Email, Notification::Tweet, Notification::FbPost
    
    #Associations
    belongs_to                :user
    belongs_to                :category
    validates_presence_of     :title, :body, :user
    
    #Special Attributes
    serialize                 :intended_for, Array
    friendly_id               :title, :use => :slugged
    
    #Scopes
    default_scope             order('kublog_posts.updated_at DESC') 
    
    def to_s
      title.titleize
    end
    
    # Public Access to the Post
    def url
      Engine.routes.url_helpers.quickie_url(self, :host => Kublog.default_url_options[:host])
    end
    
    def test
      debugger
      puts 'bla'
    end
    
  end
end