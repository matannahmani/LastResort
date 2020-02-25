class CreateStructures < ActiveRecord::Migration[5.2]
  def change
    create_table :structures do |t|
      t.string :unit_name
      t.integer :wood
      t.integer :water
      t.integer :iron
      t.integer :gold
      t.integer :hp
      t.integer :attack
      t.integer :range

      t.timestamps
    end
  end
end
