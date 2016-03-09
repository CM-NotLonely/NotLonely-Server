class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :nickname
      t.boolean :sex
      t.text :introduction

      t.timestamps null: false
    end
  end
end
