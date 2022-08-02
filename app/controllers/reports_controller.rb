class ReportsController < ApplicationController
  before_action :set_report, only: %i[show destroy]

  def index
    @reports = Report.order(:id).eager_load(:user).page(params[:page])
    @current_user = current_user
  end

  def new
    @report = Report.new
  end

  def show
  end

  def create
    @report = Report.new(report_params)

    if @report.save
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new
    end
  end

  def destroy
    @report.destroy

    redirect_to reports_path
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :body)
  end
end
