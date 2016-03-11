class CreateGroupInvites < ActiveRecord::Migration
  def change
    create_table :group_invites do |t|
      t.integer :group_id
      t.integer :user_invited_id
      t.integer :isagree

      t.timestamps null: false
    end
  end
end
