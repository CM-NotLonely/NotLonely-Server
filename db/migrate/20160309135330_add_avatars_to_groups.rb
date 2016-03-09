class AddAvatarsToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :avatar, :string
  end
end
