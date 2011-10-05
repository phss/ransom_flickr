Feature: Saving notes
  In order to blackmail someone
  As a criminal
  I want to be able to save a generated note

  Scenario: Don't show the save button before generating the note
    When I visit the home page
    Then I should not see the Save button

  Scenario: Showing the save button
    Given the following saved entries
      | character   | image_url                    | image_id |
      | a           | http://fakeflicker/a.jpg     | 1        |
     And I visit the home page
    When I enter a message "aaa"
     And I click Generate
    Then I should see the Save button

  Scenario: Saving note
    Given the following saved entries
      | character   | image_url                    | image_id |
      | a           | http://fakeflicker/a.jpg     | 1        |
      | b           | http://fakeflicker/b.jpg     | 2        |
      | c           | http://fakeflicker/c.jpg     | 3        |
     And I visit the home page
     And I enter a message "abc"
     And I click Generate
    When I click Save
    Then I should see status message "Note saved. Copy the url and send it to your 'friends'."
     And I should see image urls in the following order
      | url                         | position |
      | http://fakeflicker/a.jpg    | 0_0      |
      | http://fakeflicker/b.jpg    | 0_1      |
      | http://fakeflicker/c.jpg    | 0_2      |

  Scenario: Viewing saved note
    Given the following saved entries
      | character   | image_url                    | image_id |
      | a           | http://fakeflicker/a.jpg     | 1        |
      | b           | http://fakeflicker/b.jpg     | 2        |
      | c           | http://fakeflicker/c.jpg     | 3        |
     And the note "abc" with key "blah123"
    When I view note with key "blah123"
    Then I should see image urls in the following order
      | url                         | position |
      | http://fakeflicker/a.jpg    | 0_0      |
      | http://fakeflicker/b.jpg    | 0_1      |
      | http://fakeflicker/c.jpg    | 0_2      |      