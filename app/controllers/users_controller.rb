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
end
