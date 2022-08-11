class Book::CommentsController < ApplicationController
  before_action :set_book

  def create
    @comment = @book.comments.new(body: params[:body], user_id: current_user.id)

    if @comment.save
      redirect_to @book, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      @comments = @book.comments.preload(:user)
      render 'books/show'
    end
  end

  def destroy
    current_user.comments.find(params[:id]).destroy

    redirect_to @book, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
