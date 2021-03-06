When(/^I logout$/) do
  visit '/#/logout'
  visit '/#/logout'
  widget?(:login_form).should be true
end

Given(/^the account (.+) exists$/) do |email|
  FactoryGirl.create(:user, email: email, password: 'password', display_name: 'Dylan') if User.where(email: email).count == 0
end

When(/^I create the following habits:$/) do |table|
  table.hashes.each do |row|
    step "I visit the new habits page"
    step "I create a habit with the following information:", table(%{
      | title     | #{row['title']}   |
      | unit      | #{row['unit']}    |
      | private   | #{row['private']} |
      | target    | 3                 |
      | timeframe | week              |
    })
  end
end

When(/^I login with the following information:$/) do |table|
  visit '/#/login'
  widget?(:login_form).should be true
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

Then(/^I should be brought to the login form$/) do
  widget?(:login_form).should be true
end

When(/^I signup with the following information:$/) do |table|
  visit '/#/signup'
  form = widget(:signup_form)
  form.widget(:display_name).set(table.rows_hash['display_name'])
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
  widget?(:habit_form).should be true
end

Given(/^a logged in account with the following information:$/) do |table|
  User.create(
    email: table.rows_hash['email'],
    password: table.rows_hash['password'],
    display_name: 'Dylan'
  )
  step "I login with the following information:", table
  widget?(:habit_form).should be true
end

Then(/^I should see an error message$/) do
  widget?(:error).should be true
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

When(/^I view the login page$/) do
  visit '/#/login'
end

Then(/^I should see a link to reset my password$/) do
  widget(:login_form).widget?(:forgot_password).should be true
end

When(/^I click the forgot password link$/) do
  widget(:login_form).widget(:forgot_password).click
end

Then(/^I should be brought to a page to reset my password$/) do
  widget?(:forgot_password_form).should be true
end

When(/^I enter my account information$/) do
  widget(:forgot_password_form).widget(:email).set('dev@mojotech.com')
end

Given(/^I created an account$/) do
  step "the account dev@mojotech.com exists"
end

When(/^I view the forgot password page$/) do
  visit '/#/forgot-password'
end

When(/^I click the reset password button$/) do
  widget(:forgot_password_form).widget(:reset).click
end

Then(/^I should be sent an email to reset my password$/) do
  widget(:forgot_password_form).widget?(:sent).should be true
end

When(/^I enter an unexisting account$/) do
  widget(:forgot_password_form).widget(:email).set('asdf4w2^&adf21@gmail.com')
end

Then(/^I should be told the account is invalid$/) do
  widget(:forgot_password_form).widget(:error).text.should eq "The specified account doesn't exist."
end

Then(/^I should be told to provide a display name$/) do
  widget(:signup_form).widget?(:error, "display name can't be blank").should be true
end

Given(/^I created a new account$/) do
  FactoryGirl.create(:user, email: 'dev@mojotech.com', password: 'password')
end

When(/^I signup with the same email$/) do
  visit '/#/signup'
  form = widget(:signup_form)
  form.widget(:display_name).set 'Dylan'
  form.widget(:email).set 'dev@mojotech.com'
  form.widget(:password).set 'password'
  form.submit_form()
end
