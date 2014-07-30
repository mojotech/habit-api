Given(/^A habit can be private$/) do
  habit = FactoryGirl.create :habit, private: true
  expect(habit.private).to be true
end

Given(/^A habit can be public$/) do
  habit = FactoryGirl.create :habit, private: false
  expect(habit.private).to be false
end

Given(/^A habit can't have any other visibility$/) do
  habit = FactoryGirl.create :habit, private: 'shared'
  expect(habit.private).to be false
end

Given(/^A habit's visibility must be set when the habit is created$/) do
  habit = FactoryGirl.build(:habit)
  habit.valid?
  expect(habit.errors[:private].count).to be 1
end

Given(/^A public habit can be converted to private$/) do
  current_user = FactoryGirl.create(:user)
  current_user.habits << FactoryGirl.create(:habit, private: false)
  current_user.habits.last.convert_or_update({ private: true }, current_user)
  expect(current_user.habits.last.private?).to be true
end

Given(/^A private habit can be converted to public$/) do
  current_user = FactoryGirl.create(:user)
  current_user.habits << FactoryGirl.create(:habit, private: true)
  current_user.habits.last.convert_or_update({ private: false }, current_user)
  expect(current_user.habits.last.public?).to be true
end

Given(/^A shared habit can be converted to private$/) do
  user_one = FactoryGirl.create(:user)
  user_one.habits << FactoryGirl.create(:habit, private: false)

  user_two = FactoryGirl.create(:user)
  shared_habit = Habit.associate_matching_or_create({
    title: user_one.habits.last.attributes["title"],
    unit: user_one.habits.last.attributes["unit"],
    private: false
  }, user_two)

  expect(Habit.count).to be 1

  shared_habit.convert_or_update({ private: true }, user_two)

  expect(Habit.count).to be 2
  expect(user_one.habits.first.public?).to be true
  expect(user_two.habits.first.private?).to be true
end

Given(/^A public habit can have its attributes edited$/) do
  step "A habit can be public"
  Habit.first.convert_or_update({ title: "new title" }, Habit.first.users.first)
  expect(Habit.first.title).to eq "new title"
end

Given(/^A private habit can have its attributes edited$/) do
  step "A habit can be private"
  Habit.first.convert_or_update({ title: "new title" }, Habit.first.users.first)
  expect(Habit.first.title).to eq "new title"
end

Given(/^Editing attributes of a shared habit creates a new habit with those attributes$/) do
  step "A public habit can be joined, creating a shared habit"
  # expect(Habit.count).to be 2
  # Habit.first.convert_or_update({ title: "new title" }, Habit.first.users.first)
  # expect(Habit.last.title).to eq "new title"
end

Given(/^A public habit can be joined, creating a shared habit$/) do
  user_one = FactoryGirl.create(:user)
  user_one.habits << FactoryGirl.create(:habit, private: false)
  user_two = FactoryGirl.create(:user)

  Habit.associate_matching_or_create({ title: user_one.habits.last.title, private: false }, user_two)

  expect(Habit.count).to be 1
  expect(Habit.first.users.count).to be 2
  expect(Habit.first.shared?).to be true
end
