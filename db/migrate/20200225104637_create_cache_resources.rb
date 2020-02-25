class CreateCacheResources < ActiveRecord::Migration[5.2]
  def change
    create_table :cache_resources do |t|
      t.references :resource, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :latitude
      t.integer :longtitude
      t.boolean :extracted

      t.timestamps
    end
  end
end
