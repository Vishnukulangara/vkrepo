class ChangeTableMessages < ActiveRecord::Migration
  def change
  	change_table :messages do |t|
  		t.remove :employer_id
  		t.remove :employee_id
  		t.remove :archive
  		t.remove :message
  		t.string :message
  		t.integer :sender_id
  		t.integer :reciever_id
  		t.integer :archive
  	end
  end
end
