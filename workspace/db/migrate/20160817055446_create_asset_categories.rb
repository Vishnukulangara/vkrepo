class CreateAssetCategories < ActiveRecord::Migration
  def change
    create_table :asset_categories do |t|
    	t.string :asset_catogory
    	t.string :asset_type
    	t.integer :category_id
    	t.integer :type_id
    	t.integer :asset_category_id
      
    end
  end
end
