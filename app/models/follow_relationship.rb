# frozen_string_literal: true

class FollowRelationship < ApplicationRecord
  belongs_to :follow, class_name: 'User'
  belongs_to :follower, class_name: 'User'
  validates :follow_id, presence: true, numericality: { other_than: :follower_id }
  validates :follower_id, presence: true, numericality: { other_than: :follow_id }
end
