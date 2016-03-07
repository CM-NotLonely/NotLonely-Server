class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :user_id
      t.integer :user_id_followed

      t.timestamps null: false
    end
  end
end
