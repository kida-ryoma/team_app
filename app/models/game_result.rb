class GameResult < ApplicationRecord
  belongs_to :game
  has_many :game_scorers, dependent: :destroy
end
