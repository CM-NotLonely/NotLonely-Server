class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :user_id
      t.string :title
      t.text :introduction
      t.string :headimg

      t.timestamps null: false
    end
  end
end
