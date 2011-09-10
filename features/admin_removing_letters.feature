Feature: Removing characters
  In order to allow users to generate notes
  As a site administrator
  I want to be able to remove saved characters I've added by mistake

  Scenario: Removing a character
    Given the following saved entries
      | character | image_url                       | image_id |
      | A         | http://fakeflicker/image_a1.jpg | 1234     |
      | A         | http://fakeflicker/image_a2.jpg | 2234     |
     And I visit the admin page with the admin credentials
     And I browse character "A"
    When I click to remove image "1234"
    Then I should see saved images
      | Image                                  |
      | http://fakeflicker/image_a1.jpg   |
     And I should see status message "Remove successful"