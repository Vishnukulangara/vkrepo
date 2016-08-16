class CreateLoginHistories < ActiveRecord::Migration
  def change
  	create_table :login_histories do |t|
      t.belongs_to  :user, index: true
      t.datetime :login_time
      t.datetime :logout_time
      t.datetime :session_duration
      t.timestamps
    end 
  end
end
