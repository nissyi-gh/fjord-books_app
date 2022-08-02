# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show destroy update edit]

  def index
    @reports = Report.order(:id).eager_load(:user).page(params[:page]).includes(user: { avatar_attachment: :blob })
    @current_user = current_user
  end

  def new
    @report = Report.new
  end

  def show
    @comments = @report.comments
    @comment = Comment.new
    @current_user = current_user
  end

  def create
    @report = current_user.reports.new(report_params)

    if @report.save
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @report.update(report_params)
      redirect_to reports_url, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @report.destroy

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
