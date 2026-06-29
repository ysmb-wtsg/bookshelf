class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.references :board, foreign_key: true
      t.integer :rating, null: false
      t.string :title, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
