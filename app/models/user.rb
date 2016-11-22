class User < ApplicationRecord
  has_secure_password
  # has_many :user_cards
  # has_many :cards, through: :user_cards
  has_and_belongs_to_many :cards
  has_one :stat


  validates :username, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email
end
