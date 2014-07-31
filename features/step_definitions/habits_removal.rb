Given(/^I delete the habit$/) do
  widget(:habit_details).widget(:delete).click
end

Given(/^that I created a private habit$/) do
  step "I visit the new habits page"
  step "I create a habit with the following information:", table(%{
    | title   | walk dog |
    | unit    | times    |
    | private | true     |
  })
end

Then(/^I should see a delete button$/) do
  widget(:habit_details).widget?(:delete).should be true
end

Given(/^that I created a public habit$/) do
  step "I visit the new habits page"
  step "I create a habit with the following information:", table(%{
    | title   | walk dog |
    | unit    | times    |
    | private | false    |
  })
end

Given(/^that I joined a shared habit$/) do
  step "I visit the new habits page"
  step "I create a habit with the following information:", table(%{
    | title   | walk dog |
    | unit    | times    |
    | private | false    |
  })
  step "I login to a new account"
  step "I create a habit with the following information:", table(%{
    | title   | walk dog |
    | unit    | times    |
    | private | false    |
  })
end

Then(/^I should see an abandon button$/) do
  widget(:habit_details).widget?(:abandon).should be true
end

When(/^I view the habit's details$/) do
  widget(:habit_item, 'walk dog').click
end
