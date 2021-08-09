class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :name, presence: true

  has_many :aquaria, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_aquaria, through: :likes, source: :aquarium

  mount_uploader :user_image, UserImageUploader

  def aquaria
    Aquarium.where(user_id: id)
  end

  def already_liked?(aquarium)
    likes.exists?(aquarium_id: aquarium.id)
  end
end
