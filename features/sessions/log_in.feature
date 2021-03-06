Feature: User Logs In

Scenario: User can log into the app
  Given I am at the home page
  And I follow "Log In"

  Then I should see "Login"
  And I should see "Password"

  When I fill in "raid_leader" for "Login"
  And I fill in "password" for "Password"
  And I press "Log In"

  Then I should see "Characters"

Scenario: Unknown user sees error when trying to log in
  Given I am at the home page
  And I follow "Log In"

  Then I should see "Login"
  And I should see "Password"

  When I fill in "baduser" for "Login"
  And I fill in "stupidpass" for "Password"
  And I press "Log In"

  Then I should see "Login"
  And I should not see "Characters"

Scenario: System redirects user to the page they attempted to hit
  Given I am at the home page
  When I visit /profile

  Then I should see "Login"
  And I should see "Password"

  When I fill in "raid_leader" for "Login"
  And I fill in "password" for "Password"
  And I press "Log In"

  Then I should be on /profile
