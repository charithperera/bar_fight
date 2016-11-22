class Card < ApplicationRecord
  # has_many :user_cards
  # has_many :users, through: :user_cards
  has_and_belongs_to_many :users
end
