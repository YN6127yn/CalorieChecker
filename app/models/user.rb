class User < ApplicationRecord

  # Relations
  has_many :meals, dependent: :destroy

  # Validations
  validates :name, presence: true, length: {maximum:50}
  validates :password, presence:true, length: {minimum:6}, allow_nil:true
  validates :height, presence:true, numericality: { less_than: 2.5 }
  validates :weight, presence:true, numericality: { less_than: 500 }
  validates :day_of_birth, presence:true
  validate :day_of_birth_cannot_be_in_the_future
  validates :strength, presence:true,
             numericality: {only_integer: true,
                            greater_than_or_equal_to: 1,
                            less_than_or_equal_to: 3}
  validates :sex, presence:true, inclusion: {in: %w(male female)}

  # Return body math index(BMI)
  def body_math_index
    weight / (height * height)
  end

  # Return standard weight
  def standard_weight
    if sex == "male"
      # male
      height * height * 22
    else
      # female
      height * height * 21
    end
  end

  # Return basal metabolic rate(BMR)
  def basal_metabolic_rate(age)
    if sex == "male"
      # male
      male_BMR(age)
    else
      # female
      female_BMR(age)
    end
  end

  # Return daily caloric requirement
  def caloric_requirement
    age = current_age
    bmr = basal_metabolic_rate(age)
    if strength == 1
      caloric_requirement_st1(age, bmr).to_i
    elsif strength == 2
      caloric_requirement_st2(age, bmr).to_i
    else
      caloric_requirement_st3(age, bmr).to_i
    end
  end

  def all_meals
    Meal.where(user_id: id)
  end

  def meal_of(day, meal_type)
    Meal.where(user_id: id).where(day: day).where(meal_type: meal_type)
  end

  private

    # Check whether day of birth is in the future
    def day_of_birth_cannot_be_in_the_future
      if day_of_birth > Date.today
        errors.add(:day_of_birth, "You cannot be born in the future...")
      end
    end

    # Return current age
    def current_age
      date_format = "%Y%m%d"
      (Date.today.strftime(date_format).to_i - day_of_birth.strftime(date_format).to_i) / 10000
    end

    # Return male BMR
    def male_BMR(age)
      case age
      when 0..14
        weight * 31.0
      when 15..17
        weight * 27.0
      when 18..29
        weight * 24.0
      when 30..49
        weight * 22.3
      else
        weight * 21.5
      end
    end

    # Return femal BMR
    def female_BMR(age)
      case age
      when 0..14
        weight * 29.6
      when 15..17
        weight * 25.3
      when 18..29
        weight * 22.1
      when 30..49
        weight * 21.7
      else
        weight * 20.7
      end
    end

    # Return caloric requirement(strength level1)
    def caloric_requirement_st1(age, bmr)
      case age
      when 0..14
        bmr * 1.45
      when 15..17
        bmr * 1.55
      when 18..69
        bmr * 1.50
      else
        bmr * 1.45
      end
    end

    # Return caloric requirement(strength level2)
    def caloric_requirement_st2(age, bmr)
      case age
      when 0..14
        bmr * 1.65
      when 15..17
        bmr * 1.75
      when 18..69
        bmr * 1.75
      else
        bmr * 1.70
      end
    end

    # Return caloric requirement(strength level3)
    def caloric_requirement_st3(age, bmr)
      case age
      when 0..14
        bmr * 1.85
      when 15..17
        bmr * 1.95
      when 18..69
        bmr * 2.00
      else
        bmr * 1.95
      end
    end
end
