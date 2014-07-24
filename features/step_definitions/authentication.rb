Given(/^the account (.+) exists$/) do |email|
  FactoryGirl.create(:user, email: email, password: 'password') if User.where(email: email).count == 0
end

Given(/^the account (.+) has no habits$/) do |email|
  user = User.where(email: email).first
  Habit.all.each do |habit|    
    if habit.users.include? user
      if habit.users.count == 1
        habit.destroy
      else
        habit.user_ids.delete(user.id)
      end
    end
  end
end

Given(/^the account (.+) has the following habits:$/) do |email, table|
  table.hashes.each do |row|
    Habit.associate_matching_or_create(row, User.where(email: email).first)
  end
end

When(/^I login with the following information:$/) do |table|
  visit '/#/login'
  form = widget(:login_form)
  form.widget(:email).set(table.rows_hash['email'])
  form.widget(:password).set(table.rows_hash['password'])
  form.submit_form()
end

Then(/^I should see a list of my habits$/) do
  widget(:habits_list).should be_present
end

Then(/^I should see a form to add a new habit$/) do
  widget(:new_habit_form).should be_present
end

Then(/^I should be brought to the login form$/) do
  widget(:login_form).should be_present
end

