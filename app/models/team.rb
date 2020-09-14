class Team < ApplicationRecord
  has_many :users
  has_many :games
  mount_uploader :image, ImageUploader
end
