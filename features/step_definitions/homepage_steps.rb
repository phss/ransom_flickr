Given /^I visit the home page$/ do
  visit "/"
end

Then /^I should see the text area to enter the note$/ do
  page.should have_field "note"
end

When /^I enter a message "([^"]*)"$/ do |message|
  page.fill_in "note", :with => message
end

When /^I click Generate$/ do
  click_on("Generate")
end

Then /^I should see image urls in the following order$/ do |table|
  table.hashes.each do |attr| 
    page.should have_xpath("//img[@id=\"image_pos_#{attr[:position]}\" and @src=\"#{attr[:url]}\"]")
  end
end

Then /^I should not see the Save button$/ do
  page.should_not have_button "Save"
end

Then /^I should see the Save button$/ do
  page.should have_button "Save"
end

When /^I click Save$/ do
  pending
  click_on("Save")
end

When /^I view note with key "([^"]*)"$/ do |key|
  visit "/note/#{key}"
end