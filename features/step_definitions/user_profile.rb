Given(/^I have checked in to a public habit$/) do
  step "I create a habit with the following information:", table(%{
    | title     | walk dog |
    | unit      | times    |
    | private   | false    |
    | target    | 3        |
    | timeframe | week     |
  })
  step "I view the habit's details"
  widget(:habit_details).widget(:new_checkin_value).set 1
  widget(:habit_details).widget(:log).click
end

When(/^I click my display name in the checkins list$/) do
  widget(:personal_checkins).first.widget(:display_name).click
end

Then(/^I should see my profile with my public habits$/) do
  widget(:habit_item).should be_present
end

Given(/^that I join a shared habit with checkins$/) do
  step "I create a habit with the following information:", table(%{
    | title     | walk dog |
    | unit      | times    |
    | private   | false    |
    | target    | 3        |
    | timeframe | week     |
  })
  step "I view the habit's details"
  widget(:habit_details).widget(:new_checkin_value).set 1
  widget(:habit_details).widget(:log).click
  step "I logout"
  step "I login to a new account"
  step "I create a habit with the following information:", table(%{
    | title     | walk dog |
    | unit      | times    |
    | private   | false    |
    | target    | 3        |
    | timeframe | week     |
  })
  widget(:habit_item, "walk dog").click
end

When(/^I click a user name from the checkins list$/) do
  widget(:other_checkins).first.widget(:display_name).click
end

Then(/^I should see their user profile and public habits$/) do
  widget(:habit_item).should be_present
end

When(/^I view a user profile page$/) do
  step "I create a habit with the following information:", table(%{
    | title     | water plants |
    | unit      | times    |
    | private   | false    |
    | target    | 1        |
    | timeframe | week     |
  })
  widget(:new_habit_link).click
  step "that I join a shared habit with checkins"
  step "I click a user name from the checkins list"
end

Then(/^I should be able to join habits I don't currently track$/) do
  widget(:join_habit).should be_present
  widget(:join_habit).click
end

Then(/^the new habit form should include the title of that habit$/) do
  expect(widget(:habit_form).widget(:title)).to have_content "water plants"
end