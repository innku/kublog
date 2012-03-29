def login(user)
  visit '/signin'
  fill_in 'email', :with => user.email
  fill_in 'password', :with => user.password
  click_button 'Sign in'
end
