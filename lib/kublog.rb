require "kublog/engine"

module Kublog
  
  autoload   :Notifiable, 'kublog/notifiable'
  
  module Notification
    autoload :Email,      'kublog/notification/email'
    autoload :EmailJob,   'kublog/notification/email_job'
    autoload :Tweet,      'kublog/notification/tweet'
    autoload :TweetJob,   'kublog/notification/tweet_job'
    autoload :FbPost,     'kublog/notification/fb_post'
    autoload :FbPostJob,  'kublog/notification/fb_post_job'
  end
  
  module XhrUpload
    autoload :FileHelper, 'kublog/xhr_upload/file_helper'
  end
  
  mattr_accessor  :default_url_options
  @@default_url_options = {:host => 'www.example.com'}
  
  mattr_accessor  :user_kinds
  @@user_kinds = []
  
  mattr_accessor  :notification_processing
  @@notification_processing = :immediately
  
  KublogTwitter = Twitter.clone
  mattr_accessor  :twitter_client
  @@twitter_client = KublogTwitter::Client.new
  
  mattr_accessor  :facebook_client
  
  mattr_accessor  :blog_name
  @@blog_name = 'Kublog::Blog'
    
  def self.facebook_page_token=(token)
    @@facebook_client = FbGraph::User.me(token)
  end
  
  def self.setup
    yield self
  end
  
  def self.twitter
    yield @@twitter_client
  end
  
end
