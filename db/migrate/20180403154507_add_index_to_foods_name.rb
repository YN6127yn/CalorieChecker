class AddIndexToFoodsName < ActiveRecord::Migration[5.1]
  def change
    add_index :foods, :name, unique: true
    add_index :foods, :group
  end
end
