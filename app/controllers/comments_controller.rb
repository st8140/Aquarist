class CommentsController < ApplicationController
  before_action :set_aquarium

  def create
    @comment = @aquarium.comments.build(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        flash.now[:notice] = "コメントが投稿されました"
        format.js { render :index }
      else
        format.js { @status = "fail" }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.destroy
        flash.now[:notice] = "コメントを削除しました"
        format.js { render :index }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :aquarium_id)
  end

  def set_aquarium
    @aquarium = Aquarium.find(params[:aquarium_id])
  end
end
