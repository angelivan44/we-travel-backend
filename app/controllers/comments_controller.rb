class CommentsController < ApplicationController
  
  def create

    comment = Comment.new(comment_params)
    comment.user = current_user
    if comment.save
      if params[:post_id]
        post = Post.find(params[:post_id])
        post.comments.push(comment)
      end
      if params[:comment_id]
        comment = Comment.find(params[:comment_id])
      render json: comment
      end
    else
      render jsom: comment.errors
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      render json: {message: "ok"}
    else
      render comment.errors
    end
  end

  def comment_params
    params.permit(:body)
  end
end
