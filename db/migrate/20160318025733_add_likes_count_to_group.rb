class AddLikesCountToGroup < ActiveRecord::Migration
  def change
  	add_column :groups, :likes_count, :integer, default: 0
  end
end