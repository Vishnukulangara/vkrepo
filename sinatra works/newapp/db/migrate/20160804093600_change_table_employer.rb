class ChangeTableEmployers < ActiveRecord::Migration
  def change
  	change_table :employers do |t|
  		t.integer :user_employer_id
	  end
	end
end
