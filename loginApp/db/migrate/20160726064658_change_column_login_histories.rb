class ChangeColumnLoginHistories < ActiveRecord::Migration
  def change
  	change_column :login_histories, :session_duration, :float
  end
end
