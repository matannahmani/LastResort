class AddImageUrLtoResources < ActiveRecord::Migration[5.2]
  def change
    add_column :resources, :image_url, :string, default: nil
  end
end
