class CreateGroupInvites < ActiveRecord::Migration
  def change
    create_table :group_invites do |t|
      t.integer :user_id
      t.integer :user_id_invited
      t.boolean :isagree

      t.timestamps null: false
    end
  end
end