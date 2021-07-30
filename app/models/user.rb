class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  validates :name, presence: true
  has_many :aquaria, dependent: :destroy
  mount_uploader :user_image, UserImageUploader

  def aquaria
    return Aquarium.where(user_id: self.id)
  end
end
