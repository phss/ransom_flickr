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
  click_button "Generate"
end

Then /^I should see image urls in the following order$/ do |table|
  table.raw.flatten.each_with_index do |expected_url, i|
    page.should have_xpath("//div[@id=\"image_pos_#{i.to_s}\"]//img[@src=\"#{expected_url}\"]")
  end
end