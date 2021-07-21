class HomeController < ApplicationController
  before_action :forbid_login_user

  def top
  end

  def forbid_login_user
    if user_signed_in?
      redirect_to aquaria_path
    end
  end
end
