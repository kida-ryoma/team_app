class Team < ApplicationRecord
  has_many :users
  has_many :games
  
  validates :name, presence: true

  mount_uploader :image, ImageUploader

  def self.guest
    find_or_create_by!(name: "RailsFC") do |team|
      team.image = "rails.png"
    end
  end
end
