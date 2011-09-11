Feature: Generating notes
  In order to blackmail someone
  As a criminal
  I want to be able to generate ransom notes

  Scenario: Opening the home page
    Given I visit the home page
    Then I should see the text area to enter the note

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
      | http://fakeflicker/h.jpg    |
      | http://fakeflicker/e.jpg    |
      | http://fakeflicker/l.jpg    |
      | http://fakeflicker/l.jpg    |
      | http://fakeflicker/o.jpg    |
      | http://fakeflicker/per.jpg  |
      | http://fakeflicker/t.jpg    |
      | http://fakeflicker/e.jpg    |
      | http://fakeflicker/s.jpg    |
      | http://fakeflicker/t.jpg    |
      | http://fakeflicker/one.jpg  |
      | http://fakeflicker/excl.jpg |