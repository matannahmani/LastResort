class RemoveTypeFromUnit < ActiveRecord::Migration[5.2]
  def change
    remove_column :units, :type, :string
  end
end
