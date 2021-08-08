class LikesController < ApplicationController
  before_action :set_aquarium

  def create
    @like = current_user.likes.create(aquarium_id: params[:aquarium_id])
    @like.save
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js {  }
    end
  end

  def destroy
    @like = Like.find_by(aquarium_id: params[:aquarium_id], user_id: current_user.id)
    @like.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js {  }
    end
  end

  private
  def set_aquarium
    @aquarium = Aquarium.find(params[:aquarium_id])
  end

end
