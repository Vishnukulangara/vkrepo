class ChangeTableAssetCategories < ActiveRecord::Migration
  def change
  	change_table :asset_categories do |t|
  		t.remove :asset_catogory
  		t.string :asset_category
  	end
  end
end
