class CreateUserStructures < ActiveRecord::Migration[5.2]
  def change
    create_table :user_structures do |t|
        t.integer :amount
        t.integer :placed
        t.references :structure, foreign_key: true
        t.references :user, foreign_key: true

        t.timestamps
    end
  end
end
