class AddReferenceToResource < ActiveRecord::Migration[5.2]
  def change
    add_column :resources, :resources, :string
    add_reference :resources, :user_resource, foreign_key: true
  end
end
