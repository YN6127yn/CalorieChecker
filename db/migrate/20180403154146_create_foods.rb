class CreateFoods < ActiveRecord::Migration[5.1]
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :calorie
      t.string :group

      t.timestamps
    end
  end
end
