require 'spec_helper'

describe Kublog::Network::Twitter do
  
  describe '#validate' do
    
    before :all do
      @notification =Factory.build(:twitter_notification)
    end
    
    it 'is valid with content and kind' do
      @notification.should be_valid
    end
    
    it 'is invalid without tweet content' do
      @notification.content = ''
      @notification.should_not be_valid
    end
  end
  
  describe '#twitter?' do
    
    before :all do 
      @notification = Factory.build(:twitter_notification)
    end
    
    it 'is true when kind is twitter' do
      @notification.twitter?.should == true
    end 
    
    it 'is false when other than twitter' do
      @notification.kind = 'facebook'
      @notification.twitter?.should == false
    end
    
  end
  
  describe 'default_twitter?' do
    
    before :all do 
      @notification = Factory.build(:twitter_notification, :post => Kublog::Post.new)
    end
    
    it 'is true when building a new post' do
      @notification.default_twitter.should == true
    end
    
    it 'is false when updating a post' do
      @notification.post = Factory(:post)
      @notification.default_twitter.should == false
    end
    
  end
  
  describe '#after_create' do
    
    before :all do
      @notification = Factory.build(:twitter_notification, :content => 'test content')
      @post = @notification.post
    end
    
    it 'should send the content of the notification + a link to the post to twitter' do
      Kublog.twitter_client.should_receive(:update).with("test content #{@post.url}")
      @notification.save
    end
  end
  
end