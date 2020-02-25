class AddAmountToCacheResource < ActiveRecord::Migration[5.2]
  def change
    add_column :cache_resources, :amount, :integer
  end
end
