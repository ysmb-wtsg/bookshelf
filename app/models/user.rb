class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || password.present? }
  validates :password_confirmation, presence: true,  if: -> { new_record? || password.present? }

  has_many :boards, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def own?(object)
    id == object&.user_id
  end
end
