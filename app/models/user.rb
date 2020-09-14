class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, presence: true
  # validates :admin, presence: true
  belongs_to :team, optional: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
