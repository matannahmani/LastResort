class AddImageUrlToCacheResource < ActiveRecord::Migration[5.2]
  def change
    add_column :cache_resources, :image_url, :string, default: nil
  end
end
