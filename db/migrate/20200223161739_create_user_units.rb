class CreateUserUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :user_units do |t|
      t.references :unit, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
