class ChangeRateToIntegerInReviews < ActiveRecord::Migration[7.0]
  def change
    change_column :reviews, :rate, :integer, null: false, default: 0
  end
end
