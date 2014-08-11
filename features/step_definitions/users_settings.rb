Given(/^I view my account settings$/) do
  visit '/#/settings'
  sleep 1
end

Then(/^I should be able to change my password$/) do
  widget(:account_settings).widget(:current_password).should be_present
  widget(:account_settings).widget(:new_password).should be_present
  widget(:account_settings).widget(:password_confirmation).should be_present
end

Then(/^I should be able to change my display name$/) do
  widget(:account_settings).widget(:display_name).should be_present
end

Then(/^my display name should be my email$/) do
  visit '/#/settings'
  widget(:account_settings).widget(:display_name).text.should eq 'dev@mojotech.com'
end

When(/^I change my display name$/) do
  widget(:account_settings).widget(:display_name).set 'Dylan'
end

Then(/^my display name should be changed$/) do
  visit '/#/settings'
  widget(:account_settings).widget(:display_name).text.should eq 'Dylan'
end

When(/^I change my display name to be empty$/) do
  widget(:account_settings).widget(:display_name).set ''
end

Then(/^my display name should not be changed$/) do
  visit '/#/settings'
  widget(:account_settings).widget(:display_name).text.should eq 'dev@mojotech.com'
end

Then(/^I should be told to provide a valid display name$/) do
  widget(:account_settings).widget(:error, 'invalid display name').should be_present
end

When(/^I provide my current password$/) do
  widget(:account_settings).widget(:password).set 'password'
end

When(/^I enter and confirm a new password$/) do
  widget(:account_settings).widget(:new_password).set 'newpassword'
  widget(:account_settings).widget(:password_confirmation).set 'newpassword'
end

When(/^I submit the form$/) do
  widget(:account_settings).widget(:save).click
end

Then(/^my password should be changed$/) do
  visit '/#/logout'
  step "I login with the following information:", table(%{
    | email    | dev@mojotech.com |
    | password | newpassword      |
  })
  widget?(:login_form).should be false
end

When(/^I provide the wrong current password$/) do
  widget(:account_settings).widget(:current_password).set 'wrongpassword'
end

Then(/^my password should not be changed$/) do
  visit '/#/logout'
  step "I login with the following information:", table(%{
    | email    | dev@mojotech.com |
    | password | password         |
  })
  widget?(:login_form).should be false
end

Then(/^I should be told my current password is incorrect$/) do
  widget(:account_settings).widget(:error, 'wrong password')
end
