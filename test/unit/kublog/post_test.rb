require 'test_helper'

module Kublog
  class PostTest < ActiveSupport::TestCase
        
    test "not valid without a title" do
      assert !Factory.build(:post, :title => nil).valid?
    end
    
    test "not valid without a body" do
      assert !Factory.build(:post, :body => nil).valid?
    end
    
    test "not valid without a user" do
      assert !Factory.build(:post, :user_id => nil).valid?
    end

  end
end
