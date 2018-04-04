class CreateMeals < ActiveRecord::Migration[5.1]
  def change
    create_table :meals do |t|
      t.date :day
      t.string :meal_type
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
