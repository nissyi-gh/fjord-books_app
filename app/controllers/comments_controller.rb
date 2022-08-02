class CommentsController < ApplicationController
  def create
    @target = params.include?(:report_id) ? Report.find(params[:report_id]) : Book.find(params[:book_id])
    @comment = @target.comments.create(body: params[:body], user_id: current_user.id)

    if @comment.save
      redirect_to @target
    else
      render @target
    end
  end
end
