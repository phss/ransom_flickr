Feature: Generating notes
  In order to blackmail someone
  As a criminal
  I want to be able to generate ransom notes

  Scenario: Opening the home page
    Given I visit the home page
    Then I should see the text area to enter the note

  @javascript
  Scenario: Generating note
    Given the following saved entries
      | character   | image_url                    | image_id |
      | h           | http://fakeflicker/h.jpg     | 1        |
      | e           | http://fakeflicker/e.jpg     | 2        |
      | l           | http://fakeflicker/l.jpg     | 3        |
      | o           | http://fakeflicker/o.jpg     | 4        |
      | t           | http://fakeflicker/t.jpg     | 5        |
      | s           | http://fakeflicker/s.jpg     | 8        |
      | 1           | http://fakeflicker/one.jpg   | 9        |
      | period      | http://fakeflicker/per.jpg   | 10       |
      | exclamation | http://fakeflicker/excl.jpg  | 11       |
     And I visit the home page
    When I enter a message "hello. Test 1!"
     And I click Generate
    Then I should see image urls in the following order
      | url                         | position |
      | http://fakeflicker/h.jpg    | 0_0      |
      | http://fakeflicker/e.jpg    | 0_1      |
      | http://fakeflicker/l.jpg    | 0_2      |
      | http://fakeflicker/l.jpg    | 0_3      |
      | http://fakeflicker/o.jpg    | 0_4      |
      | http://fakeflicker/per.jpg  | 0_5      |
      | http://fakeflicker/t.jpg    | 1_0      |
      | http://fakeflicker/e.jpg    | 1_1      |
      | http://fakeflicker/s.jpg    | 1_2      |
      | http://fakeflicker/t.jpg    | 1_3      |
      | http://fakeflicker/one.jpg  | 2_0      |
      | http://fakeflicker/excl.jpg | 2_1      |

  @javascript
  Scenario: Note with missing images
    Given the following saved entries
      | character   | image_url                    | image_id |
      | h           | http://fakeflicker/h.jpg     | 1        |
      | o           | http://fakeflicker/o.jpg     | 2        |
     And I visit the home page
    When I enter a message "hello"
     And I click Generate
    Then I should see image urls in the following order
      | url                         | position |
      | http://fakeflicker/h.jpg    | 0_0      |
      | http://fakeflicker/o.jpg    | 0_1      |