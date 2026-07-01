class ReviewsController < ApplicationController
  def new
    @board = Board.find(params[:board_id])
    @review = Review.new
  end

  def create
    @board = Board.find(params[:board_id])
    @review = @board.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to board_path(@board), success: 'レビューを投稿しました'
    else
      flash.now[:danger] = 'レビューを投稿出来ませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @review = current_user.reviews.find(params[:id])
    @board = @review.board
  end

  def update
    @review = current_user.reviews.find(params[:id])
    @board = @review.board
    if @review.update(review_params)
      redirect_to board_path(@board), success: 'レビューを更新しました'
    else
      flash.now[:danger] = 'レビューを更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    review = current_user.reviews.find(params[:id])
    board = review.board
    review.destroy!
    redirect_to board_path(board), success: 'レビューを削除しました', status: :see_other
  end

  private

  def review_params
    permitted_params = params.require(:review).permit(:rate, :title, :body)
    permitted_params.merge!(board_id: params[:board_id]) if params[:board_id].present?
    permitted_params
  end
end