class ChangeQunatityFromFoods < ActiveRecord::Migration[7.0]
  def change
    rename_column :foods, :qunatity, :quantity
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
