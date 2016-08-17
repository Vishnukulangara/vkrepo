class ChangeColumn < ActiveRecord::Migration
  def change
  	change_column :assets, :assigned_to, :integer
  end
end
