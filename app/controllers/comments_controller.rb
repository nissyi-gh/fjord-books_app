# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_target

  def create
    @comment = @target.comments.new(body: params[:body], user_id: current_user.id)

    if @comment.save
      redirect_to @target, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    elsif @target.is_a?(Book)
      @book = @target
      render 'books/show'
    else
      @report = @target
      render 'reports/show'
    end
  end

  def destroy
    current_user.comments.find(params[:id]).destroy

    redirect_to @target, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_target
    @target = params.include?(:report_id) ? Report.find(params[:report_id]) : Book.find(params[:book_id])
  end
end
