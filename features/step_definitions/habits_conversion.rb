When(/^I edit the habit to be (private|public)$/) do |visibility|
  widget(:habit_item, 'walk dog').click
  widget(:habit_details).widget(:edit).click
  widget(:habit_form).widget(:private).set(visibility == "private")
  widget(:habit_form).submit_form
end

Then(/^I should see the habit is (private|public)$/) do |visibility|
  widget(:habits_list).has_habit_with_visibility?('walk dog', visibility).should be true
end

When(/^I login to a new account$/) do
  visit '/#/logout'
  user = FactoryGirl.create(:user)
  step "I login with the following information:", table(%{
    | email    | #{user.email}    |
    | password | #{user.password} |
  })
  widget(:habit_form).should be_present
end

When(/^I type "(.*?)" into the title field$/) do |title|
  widget(:habit_form).widget(:title).set(title)
end

Given(/^that I create a shared habit$/) do
  step "I create a habit with the following information:", table(%{
    | title     | walk dog |
    | unit      | times    |
    | private   | false    |
    | target    | 3        |
    | timeframe | week     |
  })
  step "I login to a new account"
  step "I create a habit with the following information:", table(%{
    | title     | walk dog |
    | unit      | times    |
    | private   | false    |
    | target    | 3        |
    | timeframe | week     |
  })
end

Given(/^that I create a (public|private) habit$/) do |visibility|
  step "I create a habit with the following information:", table(%{
    | title     | walk dog                   |
    | unit      | times                      |
    | private   | #{visibility == 'private'} |
    | target    | 3                          |
    | timeframe | week                       |
  })
end

Then(/^another user should be able to see the habit$/) do
  step "I login to a new account"
  step "I type \"walk dog\" into the title field"
  widget(:type_ahead).has_item?('walk dog').should be true
end

Then(/^another user should not see the habit$/) do
  step "I login to a new account"
  step "I type \"walk dog\" into the title field"
  widget?(:type_ahead).should be false
end
