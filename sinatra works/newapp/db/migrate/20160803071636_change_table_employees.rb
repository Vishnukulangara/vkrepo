class ChangeTableEmployees < ActiveRecord::Migration
  def change
  	change_table :employees do |t|
  		t.integer :employee_id
  	end

  end
end
