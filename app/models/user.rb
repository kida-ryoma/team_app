class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, presence: true
  # validates :admin, presence: true
  belongs_to :team, optional: true
  has_many :games_users
  has_many :games, through: :games_users

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
