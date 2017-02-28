When /I sign in/ do
  within("#new_user") do
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
  end
  click_button 'Log in'
end
