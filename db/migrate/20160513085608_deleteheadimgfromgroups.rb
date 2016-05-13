class Deleteheadimgfromgroups < ActiveRecord::Migration
  def change
    remove_column :groups, :headimg, :string
  end
end
