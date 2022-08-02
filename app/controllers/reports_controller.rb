class ReportsController < ApplicationController
  def index
    @reports = Report.order(:id).eager_load(:user).page(params[:page])
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

  private

  def report_params
    params.require(:report).permit(:title, :body)
  end
end
