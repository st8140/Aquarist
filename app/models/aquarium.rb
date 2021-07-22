class Aquarium < ApplicationRecord
  belongs_to :user

  def user
    return User.find_by(id: self.user_id)
  end

  mount_uploader :aquarium_image, AquariumImageUploader
end
