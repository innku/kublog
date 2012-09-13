require_relative '../../lib/kublog/comment_mailer_manager'

describe "CommentMailerManager" do
  describe "necessary_notifications?" do
    let(:admin_user) { stub }

    context "The post was made by an admin" do
      let(:admin_post) { stub(:invited_author => nil, :user => admin_user) }
      
      it "should return true if the comment user is not the admin" do
        comment = stub(:user => stub, :post => admin_post)
        CommentMailerManager.necessary_notifications?(comment).should be_true
      end

      it "should return false if the comment user is the admin" do
        comment = stub(:user => admin_user, :post => admin_post)
        CommentMailerManager.necessary_notifications?(comment).should be_false
      end
    end

    context "The post was made by an invited author" do
      let(:invited_author_post) { stub(:invited_author => stub) }
     
      it "should return true if the post has an invited author" do
        comment = stub(:user => stub, :post => invited_author_post)
        CommentMailerManager.necessary_notifications?(comment).should be_true
      end
    end
  end

  describe "comment_observers_emails" do
    let(:admin_user) { stub(:email => "admin_email") }
    let(:invited_author) { stub(:email => "invited_author_email") }

    context "The comment has an invited author" do
      let(:post) { stub(:user => admin_user, :invited_author => invited_author) }

      it "should return the email of the admin and the invited author if the comment email is external" do
        comment = stub(:email => "external_email", :post => post)
        CommentMailerManager.comment_observers_emails(comment).should == "admin_email , invited_author_email"
      end

      it "should return the email of the admin if the commenter was the invited author" do
        comment = stub(:email => "admin_email", :post => post)
        CommentMailerManager.comment_observers_emails(comment).should == "invited_author_email"
      end

      it "should return the email of the invited author if the commenter was the author" do
        comment = stub(:email => "invited_author_email", :post => post)
        CommentMailerManager.comment_observers_emails(comment).should == "admin_email"
      end
    end

    it "should return the email of the admin if there is no invited author" do
      post = stub(:user => admin_user, :invited_author => nil)
      comment = stub(:email => "external_email", :post => post)
      CommentMailerManager.comment_observers_emails(comment).should == "admin_email"
    end
  end
end
