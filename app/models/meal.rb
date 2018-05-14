class Meal < ApplicationRecord

  # Relations
  belongs_to :user
  has_many :foods, through: :food_meals
  has_many :food_meals, foreign_key: "meal_id", dependent: :destroy

  # Scope
  default_scope -> {order(date: :desc)}

  # Validates
  validates :user_id, presence: true
  validates :date, presence: true
  validate :date_cannot_be_in_the_future
  validates :meal_type, presence: true, inclusion: {in: %w(breakfast lunch dinner)}

  # Get total calorie of the meal
  def total_calorie
    sum = 0
    food_meals.each do |food_meal|
      sum += food_meal.food.calorie
    end
    return sum
  end

  # Add food to the meal
  def add_food(food)
    food_meals.create(food_id: food.id)
  end

  private

    # Check whether date is in the future
    def date_cannot_be_in_the_future
      if date > Date.today
        errors.add(:date, "You can't have meal in the future now...")
      end
    end
end
