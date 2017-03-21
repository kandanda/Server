Feature: Registration
Scenario: I register as a new user
  When I visit the home page
  And I follow "Sign In"
  And I follow "Sign up"
  Then I should see "Password confirmation"
  When I fill in "Email" with "me@somedomain.com"
  When I fill in "Password" with "mysecret"
  When I fill in "Password confirmation" with "mysecret"
  And I press "Sign up"
  Then I should see "Welcome! You have signed up successfully."
  When I follow "Sign Out"
  Then I should see "Signed out successfully."

Scenario: I try registering twice
  When I visit the home page
  When an organizer exists with email: "me@somedomain.com" and password: "mysecret"
  And I follow "Sign In"
  And I follow "Sign up"
  Then I should see "Password confirmation"
  When I fill in "Email" with "me@somedomain.com"
  When I fill in "Password" with "mysecret"
  When I fill in "Password confirmation" with "mysecret"
  And I press "Sign up"
  Then I should see "Email has already been taken"
