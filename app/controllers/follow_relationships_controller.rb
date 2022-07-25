# frozen_string_literal: true

class FollowRelationshipsController < ApplicationController
  def create
    current_user.following_relationships.create(follow_id: params[:target_id])
    find_user_and_redirect
  end

  def destroy
    current_user.following_relationships.find_by(follow_id: params[:target_id]).destroy
    find_user_and_redirect
  end

  private

  def find_user_and_redirect
    @user = User.find(params[:target_id])
    redirect_to @user
  end
end
