Given(/^I am a user creating a habit "(.*?)" in "(.*?)"$/) do |name, unit|
  visit "#/habits/new"
  form = widget(:habit_form)
  form.widget(:title).set name
  form.widget(:unit).set unit
end

Given(/^I set the target with$/) do |table|
  widget(:habit_form).widget(:target_value).set table.transpose.rows_hash['value']
  widget(:habit_form).widget(:timeframe).set table.transpose.rows_hash['timeframe']
  widget(:habit_form).submit_form()
end

Then(/^I should see the target "(.*?)"$/) do |target_description|
  expect(widget(:habit_details).widget(:target).text).to eq target_description
end

Given(/^a habit with the target$/) do |table|
  step %{I am a user creating a habit "Walk Dog" in "walks"}
  step "I set the target with", table
end

Given(/^I edit the habit to be$/) do |table|
  step %{I click the habit with the title "Walk Dog"}
  widget(:habit_details).widget(:edit).click
  step "I set the target with", table
  step %{I click the habit with the title "Walk Dog"}
end
