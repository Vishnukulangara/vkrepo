class CreateTableMessages < ActiveRecord::Migration
  def change
  	create_table :messages do |t|
  		t.integer :employer_id
  		t.integer :employee_id
  		t.string :message
  	end
  end
end
