# frozen_string_literal: true

class Report::CommentsController < ApplicationController
  before_action :set_report

  def create
    @comment = @report.comments.new(body: params[:body], user_id: current_user.id)

    if @comment.save
      redirect_to @report, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      @comments = @report.comments.preload(:user)
      render 'reports/show'
    end
  end

  def destroy
    current_user.comments.find(params[:id]).destroy

    redirect_to @report, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_report
    @report = Report.find(params[:report_id])
  end
end
