class Game < ApplicationRecord

  validates :opponent, presence: true
  validates :date, presence: true
  validates :begin_time, presence: true
  validates :finish_time, presence: true
  validates :place, presence: true

  belongs_to :team, optional: true
  has_many :notifications, dependent: :destroy
  has_many :games_users, dependent: :destroy
  has_many :users, through: :games_users


  # ◆カレンダー：gem simple_calendarでは"start_time"と"end_time"ベースでカレンダーのdayに入る。今回は日付と時間の入力を分けており、時間カラムには今日に日付が入ってしまうため、simple_calendarの仕様踏まえて明示的にstart_timeとend_timeを日付カラムの日にちに設定しなければならない。そのため開始時間と終了時間の命名をかぶらないようにbegin_timeとfinish_timeにした。
  def start_time
    date
  end

  def end_time
    date
  end

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

  # ◆通知機能（リマインド）
  def create_notification_remind_game(current_user, visited_id)
    notification = current_user.active_notifications.new(
      game_id: id,
      visited_id: visited_id,
      action: 'remind_game'
    )
    # 自分へは通知が作られない・届かないようにする
    notification.save if notification.visitor_id != notification.visited_id && notification.valid?
  end
end
