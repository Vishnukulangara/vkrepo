class CreateTableCompanies < ActiveRecord::Migration
  def change
  	create_table :companies do |t|
  		t.belongs_to :employer
  		t.string :company_name
  		t.string :company_address
  		t.string :company_website
  		t.string :image
  	end
  end
end
