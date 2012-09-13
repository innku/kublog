require_relative '../../../app/helpers/kublog/posts_helper'

describe "PostsHelper" do
  let(:helper) { stub.extend Kublog::PostsHelper }

  describe "#display_invited_author_form" do
    it "should return false if the post it is a new record" do
      post = stub(:new_record? => true)
      helper.display_invited_author_form?(post).should be_false
    end

    context "The post it's not a new record" do
      let(:post) { stub(:new_record? => false) }

      it "should return false if the invited author is a new record" do
        invited_author = stub(:new_record? => true)
        post.stub!(:invited_author => invited_author)
        helper.display_invited_author_form?(post).should be_false
      end

      it "should return true if it the invited author is not a new record" do
        invited_author = stub(:new_record? => false)
        post.stub!(:invited_author => invited_author)
        helper.display_invited_author_form?(post).should be_true
      end
    end
  end
end
