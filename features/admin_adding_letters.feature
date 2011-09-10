Feature: Adding letters
  In order to allow users to generate notes
  As a site administrator
  I want to be able to add letters from Flickr

  Scenario: Adding a letter
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
     And I should see status message "Save successful"

  Scenario: Browsing saved image
    Given the following saved entries
      | character | image_url                       | image_id |
      | A         | http://fakeflicker/image_a1.jpg | 1234     |
      | A         | http://fakeflicker/image_a2.jpg | 2234     |
      | B         | http://fakeflicker/image_b.jpg  | 2345     |
     And I visit the admin page with the admin credentials
    When I browse letter "A"
    Then I should see saved images
      | Image                             |
      | http://fakeflicker/image_a1.jpg   |
      | http://fakeflicker/image_a2.jpg   |

  Scenario: Highlighting saved images
    Given an Image service with the following entries
      | Character | Image                                       | Image ID |
      | B         | http://fakeflicker/not_saved_1.jpg          | 1234     |
      | B         | http://fakeflicker/saved_2.jpg              | 2345     |
      | B         | http://fakeflicker/saved_3.jpg              | 3456     |
      | B         | http://fakeflicker/not_saved_4.jpg          | 4567     |
      | B         | http://fakeflicker/not_saved_5.jpg          | 5678     |
     And the following saved entries
      | character | image_url                       | image_id |
      | B         | http://fakeflicker/saved_2.jpg  | 2345     |
      | B         | http://fakeflicker/saved_3.jpg  | 3456     |
     And I visit the admin page with the admin credentials
    When I browse letter "B"
    Then I should only see images from service
      | Image                                       | Saved |
      | http://fakeflicker/not_saved_1.jpg          | false |
      | http://fakeflicker/saved_2.jpg              | true  |
      | http://fakeflicker/saved_3.jpg              | true  |
      | http://fakeflicker/not_saved_4.jpg          | false |
      | http://fakeflicker/not_saved_5.jpg          | false |
