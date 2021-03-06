Feature: Browsing characters
  In order to allow users to generate notes
  As a site administrator
  I want to be able to browse characters from Flickr

  Scenario: Fail to login
    When I visit the admin page with the wrong admin credentials
    Then I am not allowed to enter the admin area

  Scenario: Allow browsing of all characters
    When I visit the admin page with the admin credentials
    Then I can see a selection of all characters to browse

  Scenario: Browsing for new characters
    Given an Image service with the following entries
      | Character | Image                                       | Image ID |
      | A         | http://fakeflicker/should_not_see_this.jpg  | 1234     |
      | B         | http://fakeflicker/first_b_image.jpg        | 2345     |
      | B         | http://fakeflicker/second_b_image.jpg       | 3456     |
     And I visit the admin page with the admin credentials
    When I browse character "B"
    Then I should only see images from service
      | Image                                  |
      | http://fakeflicker/first_b_image.jpg   |
      | http://fakeflicker/second_b_image.jpg  |

  Scenario: Browsing characters in second page
    Given an Image service with the following entries
      | Character | Image                                       | Image ID |
      | B         | http://fakeflicker/first_b_image.jpg        | 1234     |
      | B         | http://fakeflicker/second_b_image.jpg       | 2345     |
      | B         | http://fakeflicker/third_b_image.jpg        | 3456     |
      | B         | http://fakeflicker/fourth_b_image.jpg       | 4567     |
      | B         | http://fakeflicker/fifth_b_image.jpg        | 5678     |
      | B         | http://fakeflicker/sixth_b_image.jpg        | 6789     |
     And I visit the admin page with the admin credentials
     And I browse character "B"
    When I go to the next page
    Then I should only see images from service
      | Image                                  |
      | http://fakeflicker/sixth_b_image.jpg   |