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
  sleep 1
end

Then(/^The habit with title "(.*?)" should have a checkin value of (-?\d+)$/) do |title, value|
  widget(:habit_item, title).widget(:value).value().should eq value
end

Then(/^the form should be cleared$/) do
  widget(:habit_details).widget(:new_checkin_value).value.should eq ''
  widget(:habit_details).widget(:note).value.should eq ''
end

When(/^I checkin without value that is not an integer$/) do
  habit_details = widget(:habit_details)
  habit_details.widget(:note).set 'that was tough'
  habit_details.widget(:log).click
end

Then(/^I should be told to provide a valid checkin value$/) do
  widget(:habit_details).widget(:error).should be_present
end
