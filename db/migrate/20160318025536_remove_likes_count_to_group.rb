class RemoveLikesCountToGroup < ActiveRecord::Migration
  def change
  	remove_column :groups, :likes_count, :integer
  end
end