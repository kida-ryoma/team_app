class Team < ApplicationRecord
  has_many :users
  has_many :games
  
  validates :name, presence: true


  mount_uploader :image, ImageUploader
end
