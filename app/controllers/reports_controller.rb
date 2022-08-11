# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show destroy update edit]

  def index
    @reports = Report.order(:id).preload(:user).page(params[:page]).includes(user: { avatar_attachment: :blob })
  end

  def new
    @report = Report.new
  end

  def show
    @comments = @report.comments.preload(:user)
    @comment = Comment.new
  end

  def create
    @report = current_user.reports.new(report_params)

    if @report.save
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new
    end
  end

  def edit
    redirect_to reports_path unless current_user?(@report.user)
  end

  def update
    @report = current_user.reports.find(params[:id])

    if @report.update(report_params)
      redirect_to reports_url, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    current_user.reports.find(params[:id]).destroy

    redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :body)
  end
end
