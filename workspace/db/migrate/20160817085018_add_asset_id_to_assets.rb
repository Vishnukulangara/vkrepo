class AddAssetIdToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :asset_id, :integer
  end
end
