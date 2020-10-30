class GamesUser < ApplicationRecord
  belongs_to :game
  belongs_to :user
  belongs_to :status

  #ゲームごとの出欠未確認数を取得
  def self.count_unconfirmed_members(game_id)
    GamesUser.where('game_id = ? and status_id >= ? ', game_id, 1).count
  end
end
