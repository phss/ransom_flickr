When /^I visit the admin page with the wrong admin credentials$/ do
  visit "/admin"
  page.driver.browser.basic_authorize("wrong", "wrong")
end

Then /^I am not allowed to enter the admin area$/ do
  page.should have_content "Access Denied"
end
