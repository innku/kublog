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
    
    it 'should not be valid without content' do
      @notification.content = ''
      @notification.should_not be_valid
    end
    
  end
  
  
end