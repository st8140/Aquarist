class Aquarium < ApplicationRecord
  validates :aquarium_introduction, presence: true, length: { maximum: 50 }
  validates :aquarium_image, presence: { message: 'を選択してください' }

  belongs_to :user
  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  mount_uploader :aquarium_image, AquariumImageUploader

  def user
    User.find_by(id: user_id)
  end
end
