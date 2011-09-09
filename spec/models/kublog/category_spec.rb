require 'spec_helper'

describe Kublog::Category do
  
  describe '#validate' do
    before :each do 
      @category = Factory :category
    end
    
    it 'is valid with the mandatory attributes' do
      @category.should be_valid
    end
    
    it 'is invalid without a name' do
      @category.name = ''
      @category.should_not be_valid
    end
    
  end
  
  describe '#to_s' do
    it 'is the titleized version of the name' do
      Factory.build(:category, :name => 'some name').to_s.should == 'Some Name' 
    end
  end
  
  describe '#as_json' do
    before :all do
      @json = JSON.parse(Factory(:category).to_json)
    end
    
    it 'includes the name of the category' do
      @json["name"].match('Features').should_not be_nil
    end
    
    it 'includes the path to the category' do
      @json["path"].match(/features/).should_not be_nil
    end
    
  end
  
end
  