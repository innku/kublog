require 'spec_helper'

describe Kublog::Author do

  class TestAuthor < ActiveRecord::Base
    set_table_name 'users'
  end
  
  describe '.included' do
    
    before :all do
      TestAuthor.send :include, Kublog::Author
    end
    
    it 'sets the environment variable to the class that included the module' do
      Kublog.author_class.should == TestAuthor.name
    end
    
    it 'should respond to posts' do
      TestAuthor.new.should respond_to(:posts)
    end
    
  end

end