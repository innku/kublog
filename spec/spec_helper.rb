ENV["RAILS_ENV"] = "test"
require 'rubygems'
require 'bundler/setup'
require 'ruby-debug'

require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'rspec/rails'
require 'factory_girl'
require 'factories'
require 'json'
require 'capybara/rspec'
require 'database_cleaner'

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  DatabaseCleaner.strategy = :truncation

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

module Support
  
  def self.dont_notify_users_by_default
    User.class_eval do
      def notify_post?(roles)
        false
      end
    end
  end
  
  def self.notify_select_users
    User.class_eval do
      def notify_post?(roles)
        roles.include?(self.kind)
      end
    end
  end
  
  def self.fixture(name='')
    File.read File.join(File.dirname(__FILE__), 'fixtures', name)
  end
  
  def self.image_fixture(name='')
    File.open File.join(File.dirname(__FILE__), 'fixtures', name)
  end
  
end
