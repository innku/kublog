require 'spec_helper'

describe Kublog::Notifiable do
  
  class TestUser; end
  
  describe '.included' do
    
    before :all do
      Kublog.notify_class = 'TestUser'
      TestUser.send :include, Kublog::Notifiable
    end
    
    it 'defaults notify_post? to true' do
      TestUser.new.notify_post?(Kublog::Post.new).should == true
    end
    
  end
  
end