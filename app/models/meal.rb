class Meal < ApplicationRecord

  # Relations
  belongs_to :user
  has_many :foods, through: :food_meals
  has_many :food_meals, foreign_key: "meal_id", dependent: :destroy

  # Scope
  default_scope -> {order(day: :desc)}

  # Validates
  validates :user_id, presence: true
  validates :day, presence: true
  validate :day_cannot_be_in_the_future
  validates :meal_type, presence: true, inclusion: {in: %w(breakfast lunch dinner)}

  def total_calorie
    sum = 0
    for food in foods
      sum += food.calorie
    end
    return sum
  end

  private

    # Check whether day is in the future
    def day_cannot_be_in_the_future
      if day > Date.today
        errors.add(:day, "You can't have meal in the future now...")
      end
    end
end
