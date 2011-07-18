Given /^I visit the home page$/ do
  visit "/"
end

Then /^I should see the text area to enter the note$/ do
  page.should have_field "note"
end