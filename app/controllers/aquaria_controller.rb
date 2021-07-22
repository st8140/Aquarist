class AquariaController < ApplicationController
  before_action :authenticate_user!

  def index
    @aquarium = Aquarium.new
    @aquaria = Aquarium.all.order(created_at: :desc)
  end

  def show
    @aquarium = Aquarium.find(params[:id])
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
      render "aquaria/new"
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
