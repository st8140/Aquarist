# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def new_guest
    @user = User.find_or_create_by!(name: "テストユーザー", email: "test@com", user_image: nil) do |user|
      user.password = SecureRandom.urlsafe_base64
    end
    sign_in @user
    redirect_to aquaria_path, notice: "テストユーザーとしてログインしました。"
  end
  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
