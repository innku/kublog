require 'spec_helper'

describe Kublog::Image do
  
  describe '#validate' do
    before :each do
      @image = Kublog::Image.new(:file => Support.image_fixture('adrian.png'))
    end
    
    it 'is valid with a file' do
      @image.should be_valid
    end
    
    # Saves the image to delete the file from filesystem
    it 'is invalid without a file' do
      @image.file.remove!
      @image.should_not be_valid
    end
  end
  
  describe '#before_validation' do
    it 'sets a default alt with the name of the image' do
      image = Kublog::Image.create(:file => Support.image_fixture('adrian.png'))
      image.alt.should == 'adrian'
    end
  end
  
  describe '#after_create' do
    it 'gets the width and height of the image' do
      image = Kublog::Image.create(:file => Support.image_fixture('adrian.png'))
      image.file_width.should == 48
      image.file_height.should == 48
    end
  end
  

end