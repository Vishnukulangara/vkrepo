class ChangeTableAssets < ActiveRecord::Migration
  def change
  	change_table :assets do |t|

  		t.string :working_condition
  	end
  end
end
