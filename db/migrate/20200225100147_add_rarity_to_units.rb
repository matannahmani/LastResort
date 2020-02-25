class AddRarityToUnits < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :type, :string
    add_column :units, :rarity, :string
    add_column :units, :range, :integer
    add_column :units, :hp, :integer
  end
end
