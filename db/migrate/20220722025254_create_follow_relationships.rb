class CreateFollowRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :follow_relationships do |t|
      t.integer :follow_id, forein_key: true
      t.integer :follower_id, foreign_key: true

      t.timestamps
    end
  end
end
