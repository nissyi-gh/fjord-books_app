# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_target

  def create
    @comment = @target.comments.new(body: params[:body], user_id: current_user.id)

    if @comment.save
      redirect_to @target
    else
      render @target
    end
  end

  def destroy
    Comment.find(params[:id]).destroy

    redirect_to @target
  end

  private

  def set_target
    @target = params.include?(:report_id) ? Report.find(params[:report_id]) : Book.find(params[:book_id])
  end
end
