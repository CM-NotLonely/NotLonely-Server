class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uestc_account
      t.boolean :isverify
      t.string :nickname
      t.boolean :sex
      t.text :introduction

      t.timestamps null: false
    end
  end
end
