Given /^I visit the home page$/ do
  visit "/"
end

Then /^I should see the text area to enter the note$/ do
  page.should have_field "note"
end

Given /^a Flicker service with the following entries$/ do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

When /^I browse letter "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see images$/ do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end
