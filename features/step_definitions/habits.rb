Given(/^I created the following habits:$/) do |table|
  table.hashes.each do |row|
    step "I visit the new habits page"
    step "I create a habit with the following information:", table(%{
      | title     | #{row['title']}     |
      | unit      | #{row['unit']}      |
      | private   | #{row['private']}   |
      | target    | #{row['target']}    |
      | timeframe | #{row['timeframe']} |
    })
  end
end

Then(/^I should see a link to add a new habit$/) do
  widget(:new_habit_link).should be_present
end

Given(/^I visit the new habits page$/) do
  visit '/#/habits/new'
  widget?(:habit_form).should be true
end

When(/^I create a habit with the following information:$/) do |table|
  form = widget(:habit_form)
  form.widget(:title).set(table.rows_hash['title'] || '')
  form.widget(:unit).set(table.rows_hash['unit'] || '')
  form.widget(:private).set(table.rows_hash['private'] == 'true')
  form.widget(:target_value).set table.rows_hash['target'] || ''
  form.widget(:timeframe).set table.rows_hash['timeframe']
  form.submit_form()
  widget?(:habits_list).should be true
end

Then(/^I should see a form to enter a new habit$/) do
  widget(:habit_form).should be_present
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

Then(/^I should not see the habit "(.*?)" in my list$/) do |title|
  widget(:habits_list).has_habit?(title).should be false
end

Given(/^there is a public habit "(.*?)"$/) do |title|
  step "I visit the new habits page"
  step "I create a habit with the following information:", table(%{
    | title     | #{title} |
    | unit      | times    |
    | private   | false    |
    | target    | 3        |
    | timeframe | day      |
  })
  step "I login to a new account"
end

Then(/^I should see a suggestion for "(.*?)"$/) do |title|
  widget(:type_ahead).has_item?(title).should be true
end

When(/^I click the suggestion for "(.*?)"$/) do |title|
  widget(:type_ahead).click_suggestion(title)
end

Then(/^I should be able to unjoin the public habit$/) do
  widget(:habit_form).widget?(:cancel).should be true
end

When(/^I cancel out of the public habit$/) do
  widget(:habit_form).widget(:cancel).click
end

Then(/^I should see a link to return home$/) do
  widget(:navbar).widget(:home).should be_present
end

When(/^I create a habit without a title$/) do
  visit '/#/habits/new'
  form = widget(:habit_form)
  form.widget(:unit).set 'walks'
  form.widget(:private).set true
  form.widget(:target_value).set 5
  form.widget(:timeframe).set 'week'
  form.submit_form()
end

When(/^I create a habit without a target value$/) do
  visit '/#/habits/new'
  form = widget(:habit_form)
  form.widget(:title).set 'walk dog'
  form.widget(:unit).set 'walks'
  form.widget(:private).set true
  form.widget(:timeframe).set 'week'
  form.submit_form()
end

When(/^I create a habit without a target unit$/) do
  visit '/#/habits/new'
  form = widget(:habit_form)
  form.widget(:title).set 'walk dog'
  form.widget(:private).set true
  form.widget(:target_value).set 5
  form.widget(:timeframe).set 'week'
  form.submit_form()
end

When(/^I create a habit with an invalid target value$/) do
  visit '/#/habits/new'
  form = widget(:habit_form)
  form.widget(:title).set 'walk dog'
  form.widget(:unit).set 'times'
  form.widget(:private).set true
  form.widget(:target_value).set 'd'
  form.widget(:timeframe).set 'week'
  form.submit_form()
end

Then(/^I should be told to provide a title$/) do
  widget(:habit_form).widget(:error, "title can't be blank").should be_present
end

Then(/^I should be told to provide a target unit$/) do
  widget(:habit_form).widget(:error, "unit can't be blank").should be_present
end

Given(/^I created a new habit$/) do
  Habit.associate_matching_or_create({ title: 'walk my dog' }, User.first)
end

When(/^I type part of the habit's title into the title field$/) do
  widget(:habit_form).widget(:title).set 'walk my do'
end

Then(/^I shouldn't see a suggestion for the habit$/) do
  widget?(:type_ahead).should be false
end
