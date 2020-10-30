class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, presence: true
  # validates :admin, presence: true
  belongs_to :team, optional: true
  has_many :games_users
  has_many :games, through: :games_users
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :game_scorers, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(email: "test1@test.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "testユーザー"
      user.admin = 1
    end
  end
end
