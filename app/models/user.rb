class User < ApplicationRecord
    has_secure_password

    validates :name, presence: true, length: { maximum: 255 }
    validates :email, presence: true, uniqueness: true
    validates :password, length: { minimum: 3 }, if: -> { new_record? || password.present? }
    validates :password_confirmation, presence: true,  if: -> { new_record? || password.present? }
end
