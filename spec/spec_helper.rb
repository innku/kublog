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
require 'headless'
require 'capybara-webkit'

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do 
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    if example.metadata[:js]
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.start
    end
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # Headless browser
  Capybara.javascript_driver = :webkit
  config.before(:suite) do 
    headless = Headless.new
    headless.start
    at_exit do
      headless.destroy
    end
  end

  # More speed
  Capybara.automatic_reload = false
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
