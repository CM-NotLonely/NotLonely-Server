class CreateActivityApplies < ActiveRecord::Migration
  def change
    create_table :activity_applies do |t|
      t.integer :user_id
      t.integer :activity_id
      t.integer :isagree

      t.timestamps null: false
    end
  end
end
