class Message < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  belongs_to :room

  def create_notification_dm(current_user, visited_id)
    notification = current_user.active_notifications.new(
      message_id: id,
      visited_id: visited_id,
      action: 'dm'
    )
    notification.save if notification.valid?
  end
end
