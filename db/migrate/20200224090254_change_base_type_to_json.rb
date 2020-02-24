class ChangeBaseTypeToJson < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :base, :json, using: 'base::JSON'
  end
end
