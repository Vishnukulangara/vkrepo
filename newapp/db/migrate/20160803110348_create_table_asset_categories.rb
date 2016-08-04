class CreateTableAssetCategories < ActiveRecord::Migration
  def change
  	create_table :asset_categories do |t|
  		t.string :category
  		t.integer :category_id
  		t.string :type
  		t.integer :type_id
  		t.integer :a_c_id
  	end
  end
end
