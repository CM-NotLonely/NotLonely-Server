class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :user_followed_id
      t.integer :user_follow_id

      t.timestamps null: false
    end
  end
end
