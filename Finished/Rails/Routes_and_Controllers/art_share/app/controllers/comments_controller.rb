class CommentsController < ApplicationController
  def index
    if params.include?(:user_id)
      render json: Comment.where(user_id: params[:user_id])
    elsif params.include?(:artwork_id)
      render json: Comment.where(artwork_id: params[:artwork_id])
    else
      render json: Comment.all
    end
  end

  def create
    new_comment = Comment.new(comment_params)

    if new_comment.save
      render json: new_comment
    else
      render json: new_comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: comment
  end

  def like
    new_like = Like.new(user_id: params[:user_id], likeable_id: params[:id], likeable_type: 'Comment')

    if new_like.save
      render json: new_like
    else
      render json: new_like.errors.full_messages, status: :unprocessable_entity
    end
  end

  def unlike
    like = Like.find_by(user_id: params[:user_id], likeable_id: params[:id], likeable_type: 'Comment')

    if like.save
      render json: like
    else
      render json: like.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :artwork_id, :body)
  end
end
