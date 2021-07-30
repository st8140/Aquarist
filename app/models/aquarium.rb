class Aquarium < ApplicationRecord
  belongs_to :user

  validates :aquarium_introduction, presence: true, length: {maximum: 50}       
  validates :aquarium_image, presence: { message: 'を選択して下さい。' }

  def user
    return User.find_by(id: self.user_id)
  end

  mount_uploader :aquarium_image, AquariumImageUploader
end
