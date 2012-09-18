require 'spec_helper'

describe Kublog::Author do

  class TestAuthor < ActiveRecord::Base
    self.table_name = 'users'
  end
  
  describe '.included' do
    
    before :all do
      TestAuthor.send :include, Kublog::Author
    end
    
    it 'should respond to posts' do
      TestAuthor.new.should respond_to(:posts)
    end
    
  end

end