class ChangeLatitudeAndLongtitudeToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :cache_resources, :latitude, :float
    change_column :cache_resources, :longtitude, :float
  end
end
