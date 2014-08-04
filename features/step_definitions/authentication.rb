When(/^I logout$/) do
  visit '#/logout'
  sleep 2
end

Given(/^the account (.+) exists$/) do |email|
  FactoryGirl.create(:user, email: email, password: 'password') if User.where(email: email).count == 0
end

When(/^I create the following habits:$/) do |table|
  table.hashes.each do |row|
    step "I visit the new habits page"
    step "I create a habit with the following information:", table(%{
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
  widget(:habit_form).should be_present
end

Then(/^I click the logout link$/) do
  visit '/#habits/'
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

Given(/^I am logged in$/) do
  user = FactoryGirl.create(:user)
  step "I login with the following information:", table(%{
    | email    | #{user.email}    |
    | password | #{user.password} |
  })
end

Given(/^a logged in account with the following information:$/) do |table|
  User.create(
    email: table.rows_hash['email'],
    password: table.rows_hash['password']
  )
  step "I login with the following information:", table
end

Given(/^the account "(.*?)" has the following habits:$/) do |email, table|
  user = User.where(email: email).first
  table.hashes.each do |row|
    matching_habits = user.habits.where(title: row['title'], unit: row['unit'], private: row['private'])
    if matching_habits.count == 0
      user.habits.create(title: row['title'], unit: row['unit'], private: row['private'])
    end
  end
end

Then(/^I should see an error message$/) do
  widget(:login_form).widget?(:error).should be true
end

Then(/^I should be told the account already exists$/) do
  widget(:signup_form).widget?(:error, 'email has already been taken').should be true
end

Then(/^I should be told to provide a valid email$/) do
  widget(:signup_form).widget?(:error, 'email is invalid').should be true
end

Then(/^I should be told to provide a longer password$/) do
  widget(:signup_form).widget?(:error, 'password is too short (minimum is 8 characters)').should be true
end

Then(/^I should be told to provide a password$/) do
  widget(:signup_form).widget?(:error, "password can't be blank").should be true
end
