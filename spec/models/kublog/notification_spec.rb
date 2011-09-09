require 'spec_helper'

describe Kublog::Notification do
  
  describe '#validate' do
    before(:each) do
      @notification = Factory.build(:notification)
    end
    
    it 'should be valid with the correct attributes' do
      @notification.should be_valid
    end
    
    it 'should not be valid without a kind' do
      @notification.kind = ''
      @notification.should_not be_valid
    end
  end
  
  describe '#roles' do
    it 'serializes roles into a hash or an array' do
      notification = Factory(:notification)
      notification.roles = [:shipper, :carrier, :logistics]
      notification.save
      notification.reload
      notification.roles.should == [:shipper, :carrier, :logistics]
    end
  end
  
  describe '#title' do
    it 'delegates title to post' do
      @notification = Factory.build :notification, :post => Factory.build(:post)
      @notification.title.should == @notification.post.title
    end
  end
  
  describe '#url' do
    it 'delegates url to the post' do
      @notification = Factory.build :notification, :post => Factory.create(:post)
      @notification.url.should == @notification.post.url
    end
  end
  
  describe '#after_create' do
    it 'calls deliver_#{notification_kind} on after create' do
      notification = Factory.build(:twitter_notification)
      notification.should_receive(:deliver_twitter).and_return(nil)
      notification.save
    end
  end
  
  
end