class Food < ApplicationRecord

  # Relations
  has_many :meals, through: :food_meals
  has_many :food_meals, foreign_key: "food_id", dependent: :destroy

  # Validations
  validates :name, presence: true, uniqueness: {case_sensitive: true},
                   length: {maximum:50}
  validates :calorie, presence: true, numericality: {only_integer: true}
  validates :group, presence: true, length: {maximum:50}
end
