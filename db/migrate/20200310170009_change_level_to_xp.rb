class ChangeLevelToXp < ActiveRecord::Migration[5.2]
  def change
  rename_column :users, :level, :xp
  end
end
