class ChangeTableLoginHistories < ActiveRecord::Migration
  def change
  	change_table :login_histories do |t|
  		t.remove :created_at
  		t.remove :updated_at
  	end
  	

  end
end
