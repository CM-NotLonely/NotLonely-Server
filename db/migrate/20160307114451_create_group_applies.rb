class CreateGroupApplies < ActiveRecord::Migration
  def change
    create_table :group_applies do |t|
      t.integer :user_id
      t.integer :group_id
      t.boolean :isagree

      t.timestamps null: false
    end
  end
end
