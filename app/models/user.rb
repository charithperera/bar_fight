class User < ApplicationRecord
  has_secure_password
  has_many :user_cards
  has_many :cards, through: :user_cards

  validates :username, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email
end
