class RemoveRefreencesFromResource < ActiveRecord::Migration[5.2]
  def change
    remove_reference :resources, :user_resource, foreign_key: true
    remove_column :resources, :resources, :string
  end
end
