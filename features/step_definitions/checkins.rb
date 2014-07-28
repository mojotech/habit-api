When(/^I checkin (positively|negatively) with a value of (\d+)$/) do |type, value|
  habit_details = widget(:habit_details)
  habit_details.widget(:new_checkin_value).set(value)
  if type == 'positively'
    habit_details.widget(:positive_checkin).click
  else
    habit_details.widget(:negative_checkin).click
  end
end

Then(/^I should see a checkin value of "(.+)"$/) do |value|  
  widget(:habit_details).root.should have_selector '.value', text: value
end
