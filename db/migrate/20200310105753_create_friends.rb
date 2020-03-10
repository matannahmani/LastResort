class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.references :sender, index: true
      t.references :receiver, index: true
      t.boolean :status
      t.boolean :pending
      t.timestamps
    end
    add_foreign_key :friends, :users, column: :sender_id
    add_foreign_key :friends, :users, column: :receiver_id
  end
end
