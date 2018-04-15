require 'test_helper'

class FoodTest < ActiveSupport::TestCase

  def setup
    @food = Food.new(name: "Banana", calorie: 86, group: "Fruit")
  end

  test "should be valid" do
    assert @food.valid?
  end

  test "name should be present" do
    @food.name = " "
    assert_not @food.valid?
  end

  test "name should be unique" do
    duplicate_food = @food.dup
    @food.save
    assert_not duplicate_food.valid?
  end

  test "name should not be too long" do
    @food.name = "a" * 51
    assert_not @food.valid?
  end

  test "calorie should be integer" do
    @food.calorie = 100.5
    assert_not @food.valid?
  end

  test "group should be present" do
    @food.group = " "
    assert_not @food.valid?
  end

  test "group should not be too long" do
    @food.group = "a" * 51
    assert_not @food.valid?
  end
end
