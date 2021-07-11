class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

def self.guest
  find_or_create_by(email: "test@com") do |user|
    user.password = Rails.application.secrets.test_account_path
  end
end

end
