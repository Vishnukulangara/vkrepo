class CreateTableNewsLetters < ActiveRecord::Migration
  def change
  	create_table :new_letters do |t|
  		t.string :content
  		t.string :subject
  		t.datetime :schedule_at
  		t.string :recipients
  	end
  end
end
