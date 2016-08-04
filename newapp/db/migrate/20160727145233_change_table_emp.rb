class ChangeTableEmployers < ActiveRecord::Migration
  def change
  	change_table :employers do |t|
  		t.string :email
  		t.string :password_digest
  	end
  end
end
