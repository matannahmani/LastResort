class CreateLevel < ActiveRecord::Migration[5.2]
  def change
    create_table :levels do |t|
      t.integer :level
      t.integer :xp
      t.string  :title
    end
  end
end
