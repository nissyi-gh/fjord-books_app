class FollowRelationshipsController < ApplicationController
  def create
    current_user.following_relationships.create!(follow_id: params[:user_id])
    redirect_to User.find(params[:user_id])
  end

  def destroy
    current_user.following_relationships.find_by!(follow_id: params[:id]).destroy
    redirect_to User.find(params[:id])
  end
end
