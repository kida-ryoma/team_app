class GameScorer < ApplicationRecord
  belongs_to :game_result
  belongs_to :user

  def self.count_scores(user_id)
    GameScorer.where(user_id: user_id).count
  end
end
