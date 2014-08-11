When(/^I checkin with a value of \-?(\d+)$/) do | value|
  habit_details = widget(:habit_details)
  habit_details.widget(:new_checkin_value).set(value)
  habit_details.widget(:positive_checkin).click
end

Then(/^I should see a checkin value of "(.+)"$/) do |value|
  widget(:habit_details).root.should have_selector '.value', text: value
end

When(/^I add a (positive|negative) checkin to the habit with title "(.*?)"$/) do |type, title|
  if type == 'positive'
    widget(:habit_item, title).widget(:positive_checkin).click
  else
    widget(:habit_item, title).widget(:negative_checkin).click
  end
  sleep 1
end

Then(/^The habit with title "(.*?)" should have a checkin value of (-?\d+)$/) do |title, value|
  widget(:habit_item, title).widget(:value).value().should eq value
end

Then(/^the form should be cleared$/) do
  widget(:habit_details).widget(:new_checkin_value).value.should eq ''
  widget(:habit_details).widget(:note).value.should eq ''
end
