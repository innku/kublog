require 'spork'

Spork.prefork do
  
  ENV["RAILS_ENV"] = "test"
  require 'rubygems'
  require 'bundler/setup'

  require File.expand_path("../dummy/config/environment.rb",  __FILE__)

  require 'factory_girl'
  require 'factories'

  RSpec.configure do |config|
    # some (optional) config here
  end

end