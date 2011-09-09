require 'spec_helper'

module Kublog::Network
  describe Email do
  
    describe '#validate' do
      before :all do
        @notification = Factory.build(:email_notification)
      end
    
      it 'is valid with content and kind' do
        @notification.should be_valid
      end
    
      it 'is invalid without tweet content' do
        @notification.content = ''
        @notification.should_not be_valid
      end
    end
  
    describe '#email?' do
      before :all do 
        @notification = Factory.build(:email_notification)
      end
    
      it 'is true when kind is twitter' do
        @notification.email?.should == true
      end 
    
      it 'is false when other than twitter' do
        @notification.kind = 'twitter'
        @notification.email?.should == false
      end
    end
  
    describe '#default_email?' do
      before :all do 
        @notification = Factory.build(:email_notification, :post => Kublog::Post.new)
      end
    
      it 'is false always' do
        @notification.default_email.should == false
      end
    end
  
    describe '#after_create' do
      it 'sends emails to all users when notify_post? is default true' do
        notification = Factory.build(:email_notification)
        Kublog::Processor.should_receive(:work)
        notification.save
      end
    end
    
    describe '.email_template' do
      before :all do
        @post = Factory :post, :body => 'Hello'
      end
      
      it 'renders the body of the post as the template' do
        Kublog::Notification.email_template(@post).should == Support.fixture('rendered_email.html')
      end
    end
    
    describe Email::BulkEmail do
      before :all do
        User.destroy_all
        2.times { Factory(:user) }
        @bulk_email = Email::BulkEmail.new(Factory(:email_notification))
      end
    
      describe '#perform' do    
        it 'sends e-mails to all users when notify_post? is true' do
          notification = Factory.build(:email_notification)
          Kublog::Processor.should_receive(:work).exactly(User.count).times
          @bulk_email.perform
        end
        
        it 'sends e-mail to no users when notify_post? defaults to false' do
          Support.dont_notify_users_by_default
          Kublog::Processor.should_not_receive(:work)
          @bulk_email.perform
        end
        
        it 'evaluates notify_post? before sending e-mails' do
          Support.notify_select_users
          Factory(:user, :kind => 'cool')
          notification = Factory.build(:email_notification, :roles => ['cool'])
          bulk_email = Email::BulkEmail.new(notification)
          Kublog::Processor.should_receive(:work).once
          bulk_email.perform
        end
        
      end
    end
    
  end
end