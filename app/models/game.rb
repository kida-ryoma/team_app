class Game < ApplicationRecord
  belongs_to :team
  has_many :games_users
  has_many :users, through: :games_users
  has_many :notifications, dependent: :destroy
end
