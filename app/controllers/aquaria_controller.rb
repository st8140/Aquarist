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
      redirect_to aquaria_path
    else
      render "aquaria/new"
    end
  end

  def edit
    @aquarium = Aquarium.find(params[:id])
  end

  def update
    @aquarium = Aquarium.find(params[:id])
    if @aquarium.update(aquarium_params)
      flash[:notice] = "投稿を更新しました"
      redirect_to aquarium_path(@aquarium)
    else
      render edit_aquarium_path(@aquarium)
    end
  end

  def destroy
    @aquarium = Aquarium.find(params[:id])
    @aquarium.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to aquaria_path
  end

private

def aquarium_params
  params.require(:aquarium).permit(:aquarium_introduction, :aquarium_image, :user_id)
end

end
