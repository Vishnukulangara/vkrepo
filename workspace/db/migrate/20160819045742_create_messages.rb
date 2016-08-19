class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.string :message
    	t.integer :sender_id
    	t.integer :reciever_id
    	t.integer :archive
      t.timestamps null: false
    end
  end
end
