class ChangeDefaultOfExtracted < ActiveRecord::Migration[5.2]
  def change
    change_column_default :cache_resources, :extracted, false
  end
end
