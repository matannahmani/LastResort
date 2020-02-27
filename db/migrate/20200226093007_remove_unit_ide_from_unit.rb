class RemoveUnitIdeFromUnit < ActiveRecord::Migration[5.2]
  def change
    remove_reference :units, :user_unit, foreign_key: true
  end
end
