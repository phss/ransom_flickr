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