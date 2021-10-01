class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :aquaria, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_aquaria, through: :likes, source: :aquarium

  has_many :comments, dependent: :destroy

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'following_id'
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'follower_id'
  has_many :followers, through: :passive_relationships, source: :following

  mount_uploader :user_image, UserImageUploader
  mount_uploader :profile_image, UserImageUploader

  validates :name, presence: true

  def aquaria
    Aquarium.where(user_id: id)
  end

  def already_liked?(aquarium)
    likes.exists?(aquarium_id: aquarium.id)
  end

  def follow(user)
    active_relationships.create!(follower_id: user.id)
  end

  def unfollow(user)
    active_relationships.find_by(follower_id: user.id).destroy
  end

  def followed_by?(user)
    # 今自分(引数のuser)がフォローしようとしているユーザーがフォローされているユーザー(passive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
    passive_relationships.find_by(following_id: user.id).present?
  end
end
