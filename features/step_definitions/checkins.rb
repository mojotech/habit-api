When(/^I checkin with a value of \-?(\d+)$/) do | value|
  habit_details = widget(:habit_details)
  habit_details.widget(:new_checkin_value).set(value)
  habit_details.widget(:log).click
end

Then(/^I should see a checkin value of "(.+)"$/) do |value|
  widget(:habit_details).root.should have_selector '.value', text: value
end

When(/^I add a positive checkin to the habit with title "(.*?)"$/) do |title|
  widget(:habit_item, title).widget(:log).click
end

Then(/^The habit with title "(.*?)" should have a checkin percentage of (-?.+)$/) do |title, value|
  widget(:habit_item, title).widget(:percentage).value().should eq value
end

Then(/^the form should show a checkin value of 2$/) do
  widget(:habit_details).widget(:new_checkin_value).get.should eq '2'
  widget(:habit_details).widget(:note).get.should eq ''
end

When(/^I checkin with a value that is not an integer$/) do
  habit_details = widget(:habit_details)
  habit_details.widget(:new_checkin_value).set 'fooo'
  habit_details.widget(:note).set 'that was tough'
  habit_details.widget(:log).click
end

Then(/^I should be told to provide a valid checkin value$/) do
  widget(:habit_details).widget(:error).should be_present
end

Then(/^I should see a default form checkin value of 1$/) do
  widget(:habit_details).widget(:new_checkin_value).get.should eq '1'
end

When(/^I checkin without changing the default value$/) do
  habit_details = widget(:habit_details)
  habit_details.widget(:new_checkin_value).get.should eq '1'
  habit_details.widget(:log).click
end

Then(/^the form should show a checkin value of 1$/) do
  widget(:habit_details).widget(:new_checkin_value).get.should eq '1'
end

When(/^I view the habit list$/) do
  widget(:navbar).widget(:home).click
end

Then(/^The habit list item with the title "(.*?)" should have a checkin value of (\d+)$/) do |title, value|
  widget(:habit_item, title).widget(:new_checkin_value).value().should eq value
end