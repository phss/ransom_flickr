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

  Scenario: Browsing for new letters
    Given a Flicker service with the following entries
      | Letter | Image                                       |
      | A      | http://fakeflicker/should_not_see_this.jpg  |
      | B      | http://fakeflicker/first_b_image.jpg        |
      | B      | http://fakeflicker/second_b_image.jpg       |
    When I visit the admin page with the admin credentials
     And I browse letter "B"
    Then I should see images
      | Image                                  |
      | http://fakeflicker/first_b_image.jp    |
      | http://fakeflicker/second_b_image.jpg  |