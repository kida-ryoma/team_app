class GamesUser < ApplicationRecord
  belongs_to :game
  belongs_to :user
  belongs_to :status
end
