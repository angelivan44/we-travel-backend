class CommentsController < ApplicationController

  include Pundit 
  
  def create
    comment = Comment.new(comment_params)
    comment.user = current_user
    
      if params[:post_id]
        post = Post.find(params[:post_id])
        post.comments.push(comment)
      end
      if params[:comment_id]
        commentRecep = Comment.find(params[:comment_id])
        commentRecep.comments.push(comment)
      end
    if comment.save
      render json: comment.as_json(include: [:likes, :comments])
    else
      render json: comment.errors
    end
  end

  def destroy
    
    comment = Comment.find(params[:id])
    authorize comment
    if comment.destroy
      render json: {message: "ok"}
    else
      render comment.errors
    end
  end

  def comment_params
    params.required(:comment).permit(:body)
  end
end
