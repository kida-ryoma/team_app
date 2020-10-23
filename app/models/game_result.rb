class GameResult < ApplicationRecord
  belongs_to :game
  has_many :game_scorers, dependent: :destroy
  accepts_nested_attributes_for :game_scorers
end
