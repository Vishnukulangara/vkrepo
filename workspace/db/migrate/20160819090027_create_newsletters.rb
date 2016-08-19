class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.string :content
      t.datetime :schedule_at
      t.string :sent_to

      t.timestamps null: false
    end
  end
end
