class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
    	t.string :name
    	t.string :category
    	t.string :type
    	t.string :belongs_to
    	t.string :specification

      t.timestamps null: false
    end
  end
end
