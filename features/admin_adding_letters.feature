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
    Given an Image service with the following entries
      | Character | Image                                       | Image ID |
      | A         | http://fakeflicker/should_not_see_this.jpg  | 1234     |
      | B         | http://fakeflicker/first_b_image.jpg        | 2345     |
      | B         | http://fakeflicker/second_b_image.jpg       | 3456     |
     And I visit the admin page with the admin credentials
    When I browse letter "B"
    Then I should see images from service
      | Image                                  |
      | http://fakeflicker/first_b_image.jpg   |
      | http://fakeflicker/second_b_image.jpg  |

  Scenario: Browsing saved image
    Given the following saved entries
      | Character | Image                           | Image ID |
      | A         | http://fakeflicker/image_a1.jpg | 1234     |
      | A         | http://fakeflicker/image_a2.jpg | 2234     |
      | B         | http://fakeflicker/image_b.jpg  | 2345     |
     And I visit the admin page with the admin credentials
    When I browse letter "A"
    Then I should see saved images
      | Image                             |
      | http://fakeflicker/image_a1.jpg   |
      | http://fakeflicker/image_a2.jpg   |
  
     
     
          