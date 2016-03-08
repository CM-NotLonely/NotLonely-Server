class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :title
      t.text :introduction
      t.string :headimg
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
