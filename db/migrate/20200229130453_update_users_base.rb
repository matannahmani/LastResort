class UpdateUsersBase < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :base, :json
    add_column :users, :base, :string, array:true, default: []
  end
end
