class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
    	t.string :name
    	t.string :email
    	t.string :address
    	t.datetime :date_of_birth
    	t.datetime :date_of_joining
    	t.string :mobile_no
    	t.string :employment_status
    	t.string :section
    	t.string :bank_account_details
    	t.string :passport_details
    	t.string :pancard_details
    	t.string :adhar_card_details
    	t.string :qualifications
    	
      
    end
  end
end
