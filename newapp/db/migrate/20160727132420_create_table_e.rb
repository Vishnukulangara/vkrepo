class CreateTableEmployers < ActiveRecord::Migration
  def change
  	create_table :employers do |t|
  		t.string :name
  		t.string :company_name
  		t.string :company_address
  		t.string :company_website
  		t.string :image_path
  	end
  end
end
