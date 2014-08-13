Given(/^I view my account settings$/) do
  visit '/#/settings'
end

Then(/^I should be able to change my password$/) do
  widget(:account_settings).widget(:current_password).should be_present
  widget(:account_settings).widget(:new_password).should be_present
  widget(:account_settings).widget(:password_confirmation).should be_present
end

Then(/^I should be able to change my display name$/) do
  widget(:account_settings).widget(:display_name).should be_present
end

When(/^I change my display name$/) do
  widget(:account_settings).should be_present
  widget(:account_settings).widget(:display_name).set 'Dylan'
end

Then(/^my display name should be changed$/) do
  visit '/#/settings'
  widget(:account_settings).widget(:display_name).get.should eq 'Dylan'
end

When(/^I change my display name to be empty$/) do
  widget(:account_settings).widget(:display_name).set ''
end

Then(/^my display name should not be changed$/) do
  visit '/#/settings'
  widget(:account_settings).widget(:display_name).get.should eq 'Dylan'
end

Then(/^I should be told to provide a valid display name$/) do
  widget(:account_settings).widget(:error, "display name can't be blank").should be_present
end

When(/^I submit the form$/) do
  widget(:account_settings).widget(:save).click
end

Given(/^I am logged in to a new account$/) do
  visit '/#/signup'
  form = widget(:signup_form)
  form.widget(:display_name).set 'Dylan'
  form.widget(:email).set 'dev@mojotech.com'
  form.widget(:password).set 'password'
  form.submit_form()
  widget?(:habit_form).should be true
end

Then(/^my display name should not be blank$/) do
  widget(:account_settings).widget(:display_name).get.should_not eq ''
end
