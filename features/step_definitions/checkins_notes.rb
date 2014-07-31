Given(/^that I created a habit$/) do
  step "that I created a public habit"
end

Then(/^I should be able to enter a note with a checkin$/) do
  widget(:habit_details).widget?(:note).should be true
end

When(/^I checkin with a note$/) do
  step "I view the habit's details"
  widget(:habit_details).widget(:note).set('awesome')
  widget(:habit_details).widget(:positive_checkin).click
end

Then(/^I should see the note in the checkins list$/) do
  widget(:habit_details).widget?(:checkins, 'awesome').should be true
end

Then(/^other users with that habit should see the note$/) do
  step "I login to a new account"
  step "that I joined a shared habit"
  step "I view the habit's details"
  widget(:habit_details).widget?(:checkins, 'awesome').should be true
end
