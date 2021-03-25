class LikesController < ApplicationController

  include Pundit 

  def create
    like = Like.new
    like.user = current_user
    if params[:post_id]
      post = Post.find(params[:post_id])
      post.likes.push(like)
    end
    if params[:comment_id]
      comment = Comment.find(params[:comment_id])
      comment.likes.push(like)
    end
    if like.save
      render json: like
    else
      render json: like.errors
    end

  end

  def destroy
    like = Like.find(params[:id])
    authorize like
    if like.destroy
      render json: {message: "ok"}
    else
      render json: like.errors
    end
  end
end
