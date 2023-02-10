class ChangeQunatityFromFoods < ActiveRecord::Migration[7.0]
  def change
    rename_column :foods, :qunatity, :quantity
  end
end
