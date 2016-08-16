class CreateTableEmployees < ActiveRecord::Migration
  def change
  	create_table :employees do |t|
  		t.belongs_to :employer
  		t.string :name
  		t.string :email
  		t.string :date_of_birth
  		t.string :address
  		t.string :date_of_joining
  		t.string :employment_status
  		t.string :section
  		t.string :bank_account_details
  		t.string :adhar_no
  		t.string :pancard_no
  		t.string :passport_details
  		t.string :qualification_details			
  		end
  end
end
