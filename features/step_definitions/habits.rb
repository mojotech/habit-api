Given(/^I created the following habits:$/) do |table|
  table.hashes.each do |row|
    step 'I visit the new habits page'
    step 'I create a habit with the following information:', table(%{
      | title   | #{row['title']}   |
      | unit    | #{row['unit']}    |
      | private | #{row['private']} |
    })
  end
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

Then(/^I should see the habit \"(.+?)\" once in my list$/) do |title|
  expect(widget(:habits_list).occurences(title)).to eq 1
end

Given(/^I click the habit with the title "(.*?)"$/) do |title|
  widget(:habit_item, title).click
end

Then(/^I should see details for the habit "(.*?)"$/) do |title|
  widget(:habit_details).widget(:title).value.should eq title
end

Given(/^I view the habit details for "(.*?)"$/) do |title|
  step "I click the habit with the title \"#{title}\""
end

Given(/^I delete the habit$/) do
  widget(:habit_details).widget(:delete).click
end

Then(/^I should not see the habit "(.*?)" in my list$/) do |title|
  widget(:habits_list).has_habit?(title).should be false
end

Given(/^I am logged in$/) do
  step 'I signup with the following information:', table(%{
      | email    | dev@mojotech.com |
      | password | password         |
    })
end
