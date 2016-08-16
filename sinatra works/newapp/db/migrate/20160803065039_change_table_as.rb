class ChangeTableAssets < ActiveRecord::Migration
  def change
  	change_table :assets do |t| 
  		
  		
  		t.string :asset_id
  		t.string :specification
  	end
  end
end
