require "rails"
require 'coffee-script'
require "jquery-rails"
require "twitter"
require "fb_graph"
require "friendly_id"
require "carrierwave"
require "RMagick"
require "sanitize"
require "liquid"

require "kublog/engine"
require "kublog/version"

module Kublog
  
  autoload   :Notifiable, 'kublog/notifiable'
  autoload   :Author,     'kublog/author'
  autoload   :Processor,  'kublog/processor'
  
  module Network
    autoload :Email,      'kublog/network/email'
    autoload :Facebook,   'kublog/network/facebook'
    autoload :Twitter,    'kublog/network/twitter'
  end
  
  module XhrUpload
    autoload :FileHelper, 'kublog/xhr_upload/file_helper'
  end
  
  module UserIntegration
    autoload :Common, 'kublog/user_integration/common'
    autoload :Devise, 'kublog/user_integration/devise'
  end
  
  mattr_accessor  :default_url_options
  @@default_url_options = {:host => 'www.example.com'}
  
  mattr_accessor  :user_kinds
  @@user_kinds = []
  
  mattr_reader    :notification_processing
  @@notification_processing = :immediately
  
  mattr_accessor  :image_storage
  @@image_storage = :file
  
  mattr_accessor :author_class
  @@author_class =  'User'
  
  mattr_accessor :notify_class
  @@notify_class =  'User'
  
  def self.notification_processing=(method='')
    @@notification_processing = method.to_sym
    if @@notification_processing == :delayed_job
      unless defined? Delayed::Job
        raise 'You must require delayed_job in your Gemfile to use this feature' 
      end
    end
  end
  
  def self.email_from(post)
    if defined?(@@from_action)
      @@from_action.yield(post)
    elsif defined?(@@from_string)
      @@from_string
    else
      'Change Me Now Kublog<test@kublog.com>'
    end
  end
  
  def self.author_email(email='', &block)
    if block_given?
      @@from_action = block 
    else
      @@from_string = email
    end
  end
  
  KublogTwitter = Twitter.clone
  mattr_accessor  :twitter_client
  @@twitter_client = KublogTwitter::Client.new
  
  mattr_accessor  :facebook_client
  
  mattr_accessor  :blog_name
  @@blog_name =   'Kublog::Blog'
    
  def self.facebook_page_token=(token)
    @@facebook_client = FbGraph::User.me(token)
  end
  
  def self.setup
    yield self
  end
  
  def self.twitter
    yield @@twitter_client
  end
  
  def self.root_path
    Engine.routes.url_helpers.root_path
  end
  
  
end