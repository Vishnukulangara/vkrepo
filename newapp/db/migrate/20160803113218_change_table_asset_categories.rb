class ChangeTableAssetCategories < ActiveRecord::Migration
  def change
  	change_table :asset_categories do |t|
  		t.remove :category
  		t.remove :type
  		t.string :asset_category
  		t.string :asset_type
  	end
  	
  end
end
