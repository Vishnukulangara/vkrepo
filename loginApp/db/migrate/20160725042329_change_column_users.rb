class ChangeColumnUsers < ActiveRecord::Migration
  def change
  	change_column :users, :mobile_no, :string
  end
end
