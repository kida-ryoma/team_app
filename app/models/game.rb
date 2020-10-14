class Game < ApplicationRecord

  validates :opponent, presence: true
  validates :date, presence: true
  validates :begin_time, presence: true
  validates :finish_time, presence: true
  validates :place, presence: true

  belongs_to :team, optional: true
  has_many :games_users
  has_many :users, through: :games_users
  has_many :notifications, dependent: :destroy

  # ◆通知機能（新規試合案内）
  def create_notification_new_game!(current_user, visited_id)
    notification = current_user.active_notifications.new(
      game_id: id,
      visited_id: visited_id,
      action: 'new_game'
    )
    # 自分へは通知が作られない・届かないようにする
    notification.save if notification.visitor_id != notification.visited_id && notification.valid?
  end
end
