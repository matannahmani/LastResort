class CreateUserResources < ActiveRecord::Migration[5.2]
  def change
    create_table :user_resources do |t|
      t.integer :amount
      t.references :resource, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
