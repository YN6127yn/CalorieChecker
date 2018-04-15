require 'test_helper'

class FoodMealTest < ActiveSupport::TestCase

  def setup
    @food_meal = FoodMeal.new(meal_id: meals(:stick_lunch).id,
                              food_id: foods(:rice).id)
  end

  test "should be valid" do
    assert @food_meal.valid?
  end

  test "should require a meal_id" do
    @food_meal.meal_id = nil
    assert_not @food_meal.valid?
  end

  test "should require a food_id" do
    @food_meal.food_id = nil
    assert_not @food_meal.valid?
  end
end
