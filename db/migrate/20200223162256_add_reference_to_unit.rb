class AddReferenceToUnit < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :units, :string
    add_reference :units, :user_unit, foreign_key: true
  end
end
