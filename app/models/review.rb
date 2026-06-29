class Review < ApplicationRecord
  validates :rate, presence: true, inclusion: { in: 1..5 }
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }

  belongs_to :user
  belongs_to :board
end
