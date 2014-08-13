Given(/^that I created a habit$/) do
  step "that I created a public habit"
end

Then(/^I should be able to enter a note with a checkin$/) do
  widget(:habit_details).widget?(:note).should be true
end

When(/^I checkin with a note$/) do
  step "I view the habit's details"
  widget(:habit_details).widget(:new_checkin_value).set 1
  widget(:habit_details).widget(:note).set('awesome')
  widget(:habit_details).widget(:log).click
end

Then(/^I should see the note in the checkins list$/) do
  widget(:habit_details).widget?(:checkins, 'awesome').should be true
end

Then(/^other users with that habit should see the note$/) do
  user = FactoryGirl.create(:user)
  step "I logout"
  form = widget(:login_form)
  form.widget(:email).set user.email
  form.widget(:password).set user.password
  form.submit_form()
  widget?(:habit_form).should be true
  step "that I joined a shared habit"
  step "I view the habit's details"
  step "I should see the note in the checkins list"
end
