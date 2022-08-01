class AddAnIndexToFollowRelationships < ActiveRecord::Migration[6.1]
  def change
    add_index :follow_relationships, :follow_id
    add_index :follow_relationships, :follower_id
    add_index :follow_relationships, [:follow_id, :follower_id], unique: true
  end
end
