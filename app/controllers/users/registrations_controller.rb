# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :check_guest, only: :destroy
  def check_guest
    if resource.email == 'test@com'
      redirect_to aquaria_path, alert: 'テストユーザーは削除できません。'
    end
  end

  def user_posts
    @user = User.find(params[:id])
    @aquarium = Aquarium.new
    @aquaria = @user.aquaria.order(created_at: :desc).page(params[:page]).per(15)
  end

  def liked_aquaria
    @user = User.find(params[:id])
    @liked_aquaria = @user.liked_aquaria.order(created_at: :desc).page(params[:page]).per(15)
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # # POST /resource
  # def create
  #   super
  # end

  # # GET /resource/edit
  # def edit
  #   super
  # end

  # # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroys
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  def detail
    @user = User.find_by(id: params[:id])
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    "/users/#{current_user.id}/detail"
  end

  def after_update_path_for(resource)
    "/users/#{current_user.id}/detail"
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
