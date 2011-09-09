require 'spec_helper'

describe Kublog::Comment do
  describe '#validate' do
    it 'is valid with an associated user' do
      Factory.build(:user_comment).should be_valid
    end
    it 'is valid with a complete anonimous user' do
      Factory.build(:anonymous_comment).should be_valid
    end
    it 'is not valid with an empty comment' do
      Factory.build(:user_comment, :body => '').should_not be_valid
      Factory.build(:anonymous_comment, :body => '').should_not be_valid
    end
    it 'is not valid to be anonymous without email' do
      Factory.build(:anonymous_comment, :author_email => '').should_not be_valid
    end
    it 'is not valid to be anonymous with an invalid email' do
      Factory.build(:anonymous_comment, :author_email => 'invalidstuff').should_not be_valid
    end
    it 'is not valid to be anonymous without a name' do
      Factory.build(:anonymous_comment, :author_name => '').should_not be_valid
    end
  end  
  
  describe '#author' do
    it 'is the user string version when its a user comment' do
      comment = Factory.build(:user_comment)
      comment.author.should == comment.user.to_s
    end
    it 'is the author name when an anonymous comments' do
      comment = Factory.build(:anonymous_comment)
      comment.author.should == comment.author_name
    end
  end
  
  describe '#as_json' do
    before :all do
      @comment = Factory(:user_comment)
      @json = JSON.parse(@comment.to_json)
    end
    it 'includes a path to the comment' do
      @json['path'].match(/\/#{@comment.id}/).should_not be_nil
    end
    it 'includes the author of the comment' do
      @json['author'].should == @comment.author
    end
    it 'includes the i18nized created_at of the comment' do
      @json['ftime'].should_not be_nil
    end
    it 'includes whether or not is an admin comment' do
      @json['admin?'].should == false
    end
  end
  
end