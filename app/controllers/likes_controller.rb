class LikesController < ApplicationController
  def create
    like = Like.new
    like.user = current_user
    like.save
    if params[:post_id]
      post = Post.find(params[:post_id])
      post.likes.push(like)
    end
    if params[:comment_id]
      comment = Comment.find(params[:comment_id])
      comment.likes.push(like)
    end
    render json: like
  end

  def destroy
    like = Like.find(params[:id])
    if like.destroy
      render json: {message: "ok"}
    else
      render json: like.errors
    end
  end
end
