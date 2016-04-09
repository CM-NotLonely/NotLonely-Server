class RemovePasswordConformationFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :password_conformation, :string
  end
end
