class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.date :day_of_birth
      t.float :height
      t.integer :weight
      t.integer :strength

      t.timestamps
    end
  end
end
