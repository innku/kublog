ENV["RAILS_ENV"] = "test"
require 'rubygems'
require 'bundler/setup'
require 'ruby-debug'
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rspec/rails'
require 'factory_girl'
require 'factories'

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end
