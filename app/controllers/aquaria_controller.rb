class AquariaController < ApplicationController
  before_action :authenticate_user!
  before_action :set_q, only: [:index, :search]

  def index
    @aquarium = Aquarium.new
    @aquaria = Aquarium.all.order(created_at: :desc).page(params[:page]).per(15)
    @like = Like.new
  end

  def show
    @aquarium = Aquarium.find(params[:id])
    @like = Like.new
    @liked_users = @aquarium.liked_users
    @comment = Comment.new
    @comments = @aquarium.comments.all.order(created_at: :desc)
  end

  def new
    @aquarium = Aquarium.new
  end

  def create
    @aquarium = Aquarium.new(aquarium_params)

    respond_to do |format|
      if @aquarium.save
        flash[:notice] = "アクアリウムを投稿しました"
        format.html { redirect_to @aquarium }
        format.js { render js: "window.location = '#{aquarium_path(@aquarium)}' " }
      else
        format.html { redirect_to @aquarium }
        format.js { @status = "fail" }
      end
    end
  end

  def edit
    @aquarium = Aquarium.find(params[:id])
  end

  def update
    @aquarium = Aquarium.find(params[:id])

    respond_to do |format|
      if @aquarium.update(aquarium_params)
        flash[:notice] = "投稿を更新しました"
        format.html { redirect_to @aquarium }
        format.js { render js: "window.location = '#{aquarium_path(@aquarium)}' " }
      else
        format.html { redirect_to @aquarium }
        format.js { @status = "fail" }
      end
    end
  end

  def destroy
    @aquarium = Aquarium.find(params[:id])
    @aquarium.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to aquaria_path
  end

  def search
    @results = @q.result.order(created_at: :desc).page(params[:page]).per(24)
    @count = @results.count
  end

  private

  def set_q
    @q = Aquarium.ransack(params[:q])
  end

  def aquarium_params
    params.require(:aquarium).permit(:aquarium_introduction, :aquarium_image, :user_id)
  end
end
