def fill_basic_post_with_no_notifications(category)
  fill_in "post_title", :with => "My title"
  fill_in_description
  select category.name, :from => "post_category_id"
end

def fill_in_description
  page.execute_script("$('#post_body').wysiwyg('destroy')")
  fill_in "post_body", :with => "<p>My description</p>"
end
