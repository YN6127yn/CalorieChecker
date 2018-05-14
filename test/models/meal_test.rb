require 'test_helper'

class MealTest < ActiveSupport::TestCase

  def setup
    @meal = Meal.new(user_id: users(:stick).id, date: Date.today, meal_type: "lunch")
  end

  test "should be valid" do
    assert @meal.valid?
  end

  test "user id should be present" do
    @meal.user_id = nil
    assert_not @meal.valid?
  end

  test "date should be past or today" do
    @meal.date = Date.today + 1
    assert_not @meal.valid?
  end

  test "meal type should be present" do
    @meal.meal_type = nil
    assert_not @meal.valid?
  end

  test "meal type should be breakfast, lunch, or dinner" do
    @meal.meal_type = "snack"
    assert_not @meal.valid?
  end

  test "should add food" do
    @meal.save
    assert_difference 'FoodMeal.count', 1 do
      @meal.add_food(foods(:rice))
    end
  end

  test "should get proper total calorie" do
    @meal.save
    rice = foods(:rice)
    bread = foods(:bread)
    @meal.add_food(rice)
    @meal.add_food(bread)
    expected = rice.calorie + bread.calorie
    actual = @meal.total_calorie
    assert_equal(expected, actual)
  end
end
