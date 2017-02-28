Feature: Sign In
Scenario: I Log in
  When I visit the home page
  And I follow "Sign In"
  And I sign in
  Then I should see "Invalid Email or password"
