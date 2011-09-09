require 'spec_helper'

describe Kublog::Notifiable do
  
  class TestUser; end
  
  describe '.included' do
    
    before :all do
      TestUser.send :include, Kublog::Notifiable
    end
    
    it 'sets up a configuration variable for the user class to notify to' do
      Kublog.notify_class.should == 'TestUser'
    end
    
    it 'defaults notify_post? to true' do
      TestUser.new.notify_post?(Kublog::Post.new).should == true
    end
    
  end
  
end