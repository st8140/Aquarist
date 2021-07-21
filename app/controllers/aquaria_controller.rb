class AquariaController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def show

  end

  def new
    @aquarium = Aquarium.new
  end

  def create
    @aquarium = Aquarium.new(aquarium_params)
    if @aquarium.save
      flash[:notice] = "アクアリウムを投稿しました"
      redirect_to aquarium_path(@aquarium.id)
    else
      render new_aquarium
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

private

def aquarium_params
  params.require(:aquarium).permit(:aquarium_introduction, :aquarium_image, :user_id)
end

end
