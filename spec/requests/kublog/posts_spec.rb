require 'spec_helper'
require_relative 'helpers/posts'
require_relative 'helpers/integration_tests'

describe "Posts" do
  describe "POST /posts" do
    before do
      @user = Factory(:user, :admin => true)
      login(@user)
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
      check("want_invited_author")
      fill_in "post_invited_author_attributes_name",  :with => "Alberto Padilla"
      fill_in "post_invited_author_attributes_email", :with => "alberto@rutanet.com"
      click_button "create_post_button"
      page.should have_content("Alberto Padilla")
    end
  end
end
