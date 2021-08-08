class Like < ApplicationRecord
  validates_uniqueness_of :aquarium_id, scope: :user_id

  belongs_to :aquarium
  belongs_to :user
end
