When /^I visit the admin page with the wrong admin credentials$/ do
  visit "/admin"
  page.driver.browser.basic_authorize("wrong", "wrong")
end

When /^I visit the admin page with the admin credentials$/ do
  page.driver.browser.basic_authorize("admin", "Demo123")
  visit "/admin"
end

Then /^I am not allowed to enter the admin area$/ do
  page.should have_content "Access Denied"
end

Then /^I can see a selection of all letters to browse$/ do
  ("A".."Z").each do |letter| 
    page.should have_link(letter, :href => "/admin/browse/#{letter.downcase}")
  end
end

Given /^an Image service with the following entries$/ do |table|
  set :image_service, FakeImageService.new(table.hashes)
end

When /^I browse letter "([^"]*)"$/ do |letter|
  visit "/admin/browser/#{letter}"
end

Then /^I should see images$/ do |table|
  table.hashes.each do |attr|
    image_link = attr[:Image]
    page.should have_xpath("//img[@src=\"#{image_link}\"]")
  end
end