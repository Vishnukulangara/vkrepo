class CreateTableAssets < ActiveRecord::Migration
  def change
  	create_table :assets do |t|
  		t.belongs_to :employer
  		t.belongs_to :employee
  		t.string :asset_name
  		t.integer :asset_number
  		t.string :working_condition
  	end
  end
end
