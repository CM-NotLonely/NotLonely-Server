class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.integer :group_id
      t.string :title
      t.string :location
      t.string :cost
      t.text :detail
      t.datetime :time

      t.timestamps null: false
    end
  end
end
