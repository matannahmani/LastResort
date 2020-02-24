class AddNicknameAndBaseAndGemsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :nickname, :string
    add_column :users, :gems, :integer
    add_column :users, :base, :text
  end
end
