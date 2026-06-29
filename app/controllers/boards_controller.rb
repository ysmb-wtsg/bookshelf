class BoardsController < ApplicationController
  PER_PAGE = 6

  def index
    @boards = Board.includes(:user).page(params[:page]).per(PER_PAGE)
  end

  def new
    @board = Board.new
  end 

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path, success: '書籍を登録しました'
    else
      flash.now[:danger] = '書籍を登録できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @board = current_user.boards.find(params[:id])
  end

  def show
    @board = Board.find(params[:id])
    @reviews = @board.reviews.includes(:user).order(created_at: :desc)
    @average_rate = @board.reviews.average(:rate).to_f.round(1) # 平均を小数点第1位まで取得
  end

  def update
    @board = current_user.boards.find(params[:id])
    if @board.update(board_params)
      redirect_to board_path(@board), success: '書籍を更新しました'
    else
      flash.now[:danger] = '書籍を更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    board = current_user.boards.find_by(id: params[:id])
    if board&.destroy
      redirect_to boards_path, success: '書籍を削除しました', status: :see_other
    else
      redirect_to boards_path, danger: '削除に失敗しました', status: :see_other
    end
  end

  private

  def board_params
    params.require(:board).permit(:title, :author, :body)
  end

end
