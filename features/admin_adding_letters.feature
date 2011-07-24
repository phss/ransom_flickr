Feature: Adding letters
  In order to allow users to generate notes
  As a site administrator
  I want to be able to add letters from Flickr

  Scenario: Fail to login
    When I visit the admin page with the wrong admin credentials
    Then I am not allowed to enter the admin area

  Scenario: Allow browsing of all letters
    When I visit the admin page with the admin credentials
    Then I can see a selection of all letters to browse