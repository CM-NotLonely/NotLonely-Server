class AddPasswordConformationToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :password_conformation, :string
  end
end
