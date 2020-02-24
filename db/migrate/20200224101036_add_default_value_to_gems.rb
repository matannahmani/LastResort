class AddDefaultValueToGems < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :gems, 0
  end
end
