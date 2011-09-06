Feature: Adding letters
  In order to allow users to generate notes
  As a site administrator
  I want to be able to remove saved letters I've added by mistake

  Scenario: Removing a letter
    Given no saved entries
     And an Image service with the following entries
      | Character | Image                                       | Image ID |
      | A         | http://fakeflicker/should_not_see_this.jpg  | 1234     |
      | B         | http://fakeflicker/first_b_image.jpg        | 2345     |
      | B         | http://fakeflicker/second_b_image.jpg       | 3456     |
     And I visit the admin page with the admin credentials
     And I browse letter "B"
    When I click to save image "2345"
    Then I should see saved images
      | Image                                  |
      | http://fakeflicker/first_b_image.jpg   |
     And I should see status message "Successfully saved new image"