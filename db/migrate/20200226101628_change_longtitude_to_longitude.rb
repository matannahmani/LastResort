class ChangeLongtitudeToLongitude < ActiveRecord::Migration[5.2]
  def change
    rename_column :cache_resources, :longtitude, :longitude
  end
end
