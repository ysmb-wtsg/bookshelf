class ChangeAuthorNullOnBoards < ActiveRecord::Migration[7.0]
  def change
    change_column_null :boards, :author, false
  end
end
