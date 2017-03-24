When /an organizer exists with email: "([^"]*)" and password: "([^"]*)"/ do |email, password|
  Organizer.create(email: email, password: password, password_confirmation: password)
end
