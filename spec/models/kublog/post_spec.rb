require 'spec_helper'

describe Kublog::Post do      
  it 'is invalid without a title' do
    Factory.build(:post, :title => nil).should_not be_valid
  end
  
  it 'is invalid with an empty body' do
    Factory.build(:post, :body => '').should_not be_valid
  end
  
  it 'is invalid with only html tags as body' do
    Factory.build(:post, :body => '<p> </p>').should_not be_valid
  end
  
  it 'is not valid without a user' do
    Factory.build(:post, :user_id => nil)
  end
  
  describe '#author' do
    it 'should return the user if there is no invited author' do
      user = Factory.build :user
      post = Factory.build :post, :user => user
      post.author.should == user
    end

    it 'should return the invited author if there is an invited author' do
      invited_author = Factory.build :invited_author
      post = Factory.build :post, :invited_author => invited_author
      post.author.should == invited_author
    end
  end
  
  describe '#to_s' do
    it 'is the posts title' do
      post = Factory.build(:post)
      post.to_s.should == post.title
    end
  end
  
  describe '#url' do
    it 'is a url to the post with the engines config url' do
      Kublog.default_url_options = {:host => 'www.myblog.com'}
      post = Factory(:post)
      post.url.should == "http://www.myblog.com/blog/#{post.to_param}"
    end
    
    it 'is nil when the post is not yet created' do
      Factory.build(:post).url.should == nil
    end
    
  end
  
  describe '#related_posts' do
    
    before(:all) do
      @category = Factory(:category)
      @post = Factory(:post, :category => @category)
    end
    
    it 'should return all the posts' do
      related_post = Factory(:post, :title => 'Related Post', :category => @category)
      unrelated_post = Factory(:post)
      @post.related_posts.should == [related_post]
    end
    
  end
  
  describe "#check_for_deleted_invited_author" do
    let(:post) { Factory(:post)}

    context "The post has an invited author" do
      let!(:invited_author) { Factory(:invited_author, :post => post)}

      it "should delete the invited author if it doesnt want it" do
        post.want_invited_author = false
        post.title = "Elias"
        post.save
        post.reload.invited_author.should be_nil
      end

      it "shouldn't delete the invited author if it wants it" do
        post.want_invited_author = "1"
        post.title = "Elias"
        post.save
        post.invited_author.should == invited_author
      end
    end

    it "shouldn't do anything if there is no invited author" do
      post.title = "Elias"
      post.save
      post.invited_author.should be_nil
    end
  end
end
