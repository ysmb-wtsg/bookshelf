class AddAuthorToBoards < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :author, :string
  end
end
