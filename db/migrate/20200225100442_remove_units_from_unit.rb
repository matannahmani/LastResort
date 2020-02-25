class RemoveUnitsFromUnit < ActiveRecord::Migration[5.2]
  def change
    remove_column :units, :units, :string
  end
end
