class RemoveImageUrLfromCacheResources < ActiveRecord::Migration[5.2]
  def change
    remove_column :cache_resources, :image_url
  end
end
