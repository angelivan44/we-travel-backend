class LikesController < ApplicationController

  include Pundit 

  def create
    like = Like.new
    like.user = current_user
    if params[:post_id]
      post = Post.find(params[:post_id])
      currentLike = post.likes.find{ |like| like.user === current_user}
      if !currentLike
        post.likes.push(like)
      else
        like = currentLike
      end
    end
    if params[:comment_id]
      comment = Comment.find(params[:comment_id])
      currentLike = comment.likes.find{ |like| like.user === current_user}
      if !currentLine
        comment.likes.push(like)
      else
        like = currentLike
      end
    end
    if like.save
      render json: like
    else
      render json: like.errors, status: :unprocessable_entity
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
