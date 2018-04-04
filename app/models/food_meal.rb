class FoodMeal < ApplicationRecord

  # Relations
  belongs_to :food
  belongs_to :meal

  # Validations
  validates: food_id, presence: true
  validates: meal_id, presence: true
end
