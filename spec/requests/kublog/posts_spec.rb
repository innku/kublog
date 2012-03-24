require 'spec_helper'
require_relative 'helpers/posts'
require_relative 'helpers/integration_tests'

describe "Posts" do
  before do
    @user = Factory(:user, :admin => true)
    login(@user)
  end

  describe "POST /posts" do
    before do
      @category = Factory(:category)
      visit "/blog/posts/new"
    end

    it "creates a Post", :js => true do
      fill_basic_post_with_no_notifications(@category)
      click_button "create_post_button"
      page.should have_content("My title")
    end

    it "creates a Post with an invited author", :js => true do
      fill_basic_post_with_no_notifications(@category)
      check("post_want_invited_author")
      fill_in "post_invited_author_attributes_name",  :with => "Alberto Padilla"
      fill_in "post_invited_author_attributes_email", :with => "alberto@rutanet.com"
      click_button "create_post_button"
      page.should have_content("Alberto Padilla")
    end
  end

  describe "POST /posts/edit" do
    before do
      @post = Factory(:post)
      visit "/blog/posts/#{@post.id}/edit"
    end

    it "updates a Post", :js => true do
      fill_in "post_title", :with => "Otro Post"
      click_button "create_post_button"
      page.should have_content("Otro Post")
    end

    it "updates a Post that didn't have an invited author", :js => true do
      check("post_want_invited_author")
      fill_in "post_invited_author_attributes_name",  :with => "Alberto Padilla"
      fill_in "post_invited_author_attributes_email", :with => "alberto@rutanet.com"
      click_button "create_post_button"
      page.should have_content("Alberto Padilla")
    end
  end
end
