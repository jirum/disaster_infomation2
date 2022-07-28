class AddRegionIdToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :region_id, :string
  end
end
