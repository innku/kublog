require 'spec_helper'
require_relative 'helpers/integration_tests'

describe "Posts" do
  describe "POST /posts" do
    before do
      @user = Factory(:user, :admin => true)
      login(@user)
      @category = Factory(:category)
      visit "/blog/posts/new"
      page.execute_script("$('#post_body').wysiwyg('destroy');")
    end

    it "creates a Post", :js => true do
      fill_in "post_title", :with => "My title"
      fill_in "post_body", :with => "<p>My description</p>"
      select @category.name, :from => "post_category_id"
      uncheck "twitter_notify"
      uncheck "facebook_notify"
      click_button "create_post_button"
      page.should have_content("My title")
    end
  end
end
