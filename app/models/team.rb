class Team < ApplicationRecord
  has_many :users
  mount_uploader :image, ImageUploader
end
