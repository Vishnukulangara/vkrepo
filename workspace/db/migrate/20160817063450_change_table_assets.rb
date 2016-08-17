class ChangeTableAssets < ActiveRecord::Migration
  def change
  	change_table :assets do |t|
  		t.remove :type
  		t.remove :category
  		t.remove :belongs_to
  		t.string :asset_type
  		t.string :asset_category
  		t.string :assigned_to
  	end
  end
end
