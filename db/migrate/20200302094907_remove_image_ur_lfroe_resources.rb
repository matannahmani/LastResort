class RemoveImageUrLfroeResources < ActiveRecord::Migration[5.2]
  def change
    remove_column :resources, :image_url
  end
end
