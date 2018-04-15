require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "User1", height: 1.7, weight: 60,
                     day_of_birth: Date.today, strength: 2, sex: "male")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "height should not be too short" do
    @user.height = 0.0
    assert_not @user.valid?
    @user.height = 0.1
    assert @user.valid?
  end

  test "height should not be too tall" do
    @user.height = 3.1
    assert_not @user.valid?
    @user.height = 3.0
    assert @user.valid?
  end

  test "weight should not be too light" do
    @user.weight = 0
    assert_not @user.valid?
    @user.weight = 1
    assert @user.valid?
  end

  test "weight should not be too heavy" do
    @user.weight = 1001
    assert_not @user.valid?
    @user.weight = 1000
    assert @user.valid?
  end

  test "weight should be integer" do
    @user.weight = 100.5
    assert_not @user.valid?
  end

  test "day of birth should be past or today" do
    @user.day_of_birth = Date.today + 1
    assert_not @user.valid?
  end

  test "strength should be in the range of 1 to 3" do
    @user.strength = 0
    assert_not @user.valid?
    @user.strength = 4
    assert_not @user.valid?
  end

  test "strength should be integer" do
    @user.strength = 1.5
    assert_not @user.valid?
  end

  test "sex should be present" do
    @user.sex = nil
    assert_not @user.valid?
  end

  test "sex should be male or female" do
    @user.sex = "superman"
    assert_not @user.valid?
  end

  test "associated meal should be destroyed" do
    @user.save
    @user.meals.create(day: Date.today, meal_type: "lunch")
    assert_difference 'Meal.count', -1 do
      @user.destroy
    end
  end
end
