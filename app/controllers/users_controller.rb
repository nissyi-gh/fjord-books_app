# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def followings
    @user = User.find(params[:id])
    @target_users = @user.followings.with_attached_avatar.order(:id).page(params[:page])
  end

  def followers
    @user = User.find(params[:id])
    @target_users = @user.followers.with_attached_avatar.order(:id).page(params[:page])
  end

  def follow
    current_user.following_relationships.create!(follow_id: params[:id])
    find_user_and_redirect
  end

  def un_follow
    current_user.following_relationships.find_by!(follow_id: params[:id]).destroy
    find_user_and_redirect
  end

  private

  def find_user_and_redirect
    @user = User.find(params[:id])
    redirect_to @user
  end
end
