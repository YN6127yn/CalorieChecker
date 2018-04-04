class CreateFoodMeals < ActiveRecord::Migration[5.1]
  def change
    create_table :food_meals do |t|
      t.references :food, foreign_key: { on_delete: :cascade }, index: true
      t.references :meal, foreign_key: { on_delete: :cascade }, index: true

      t.timestamps
    end
  end
end
