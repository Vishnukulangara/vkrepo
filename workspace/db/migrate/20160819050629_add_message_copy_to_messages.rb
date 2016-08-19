class AddMessageCopyToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :message_copy, :string
  end
end
