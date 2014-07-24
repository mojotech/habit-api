Given(/^I have the following habits:$/) do |table|
  table.hashes.each do |row|
    Habit.associate_matching_or_create(row, User.where(email: 'dev@mojotech.com').first)
  end
end

When(/^I view my habits$/) do
  visit '/#/habits'
end

Then(/^I should see a link to add a new habit$/) do
  widget(:new_habit_link).should be_present
end

Given(/^I visit the new habits page$/) do
  visit '/#/habits/new'
end

When(/^I create a habit with the following information:$/) do |table|
  form = widget(:new_habit_form)
  form.widget(:title).set(table.rows_hash['title'])
  form.widget(:unit).set(table.rows_hash['unit'])
  form.widget(:private).set(table.rows_hash['private'] == 'true')
  form.submit_form()
end

Then(/^I should see a form to enter a new habit$/) do
  widget(:new_habit_form).should be_present
end

Then(/^I should should see the following habits? in my list:$/) do |table|
  table.rows.each do |row|
    expect(widget(:habits_list).has_habit(row[0])).to be_true
  end
end

Given(/^I have the following habits created:$/) do |table|
  table.hashes.each do |row|
    Habit.associate_matching_or_create(row, User.where(email: 'dev@mojotech.com').first)
  end
end

Then(/^I should see the habit \"(.+)\" once in my list$/) do |title|
  expect(widget(:habits_list).occurences(title)).to eq 1
end
