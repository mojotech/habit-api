Given(/^the account (.+) exists$/) do |email|
  FactoryGirl.create(:user, email: email, password: 'password') if User.where(email: email).count == 0
end

When(/^I create the following habits:$/) do |table|
  table.hashes.each do |row|
    step 'I visit the new habits page'
    step 'I create a habit with the following information:', table(%{
      | title   | #{row['title']}   |
      | unit    | #{row['unit']}    |
      | private | #{row['private']} |
    })
  end
end

When(/^I login with the following information:$/) do |table|
  visit '/#/login'
  form = widget(:login_form)
  form.widget(:email).set(table.rows_hash['email'])
  form.widget(:password).set(table.rows_hash['password'])
  form.submit_form()
end

Then(/^I should see the following habits:$/) do |table|
  table.hashes.each do |row|
    widget(:habits_list).has_habit?(row['title']).should be true
  end
end

Then(/^I should see a form to add a new habit$/) do
  widget(:new_habit_form).should be_present
end

When(/^I click the logout link$/) do
  widget(:logout_link).click
end

Then(/^I should be brought to the login form$/) do
  widget(:login_form).should be_present
end

When(/^I signup with the following information:$/) do |table|
  visit '/#/signup'
  form = widget(:signup_form)
  form.widget(:email).set(table.rows_hash['email'])
  form.widget(:password).set(table.rows_hash['password'])
  form.submit_form()
end

Then(/^I should be brought to the signup form$/) do
  widget(:signup_form).should be_present
end
