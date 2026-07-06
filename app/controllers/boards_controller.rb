class BoardsController < ApplicationController
  PER_PAGE = 6

  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result(distinct: true).includes(:user, :reviews).page(params[:page]).per(PER_PAGE)
  end

  def new
    @board = Board.new
  end 

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      save_tags(@board)
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
      save_tags(@board)
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

  #タグを保存するメソッド
  def save_tags(board)

    #送信されたデータが空であれば既存のタグを全て削除してreturnで終了
    if params[:board][:tag_ids].blank?
      board.board_tags.destroy_all
      return
    end

    #既存のタグをクリア(updateアクション用で)
    board.board_tags.destroy_all

    #選択されたタグIDを1つずつ取り出して、書籍とタグを紐付けるレコードを作る
    tag_ids = params[:board][:tag_ids].reject(&:blank?)
    tag_ids.each do |tag_id|
      board.board_tags.create(tag_id: tag_id)
    end
  end

end
