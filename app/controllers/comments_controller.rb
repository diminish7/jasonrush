class CommentsController < ApplicationController

  def new
    commentable = self.class.const_get(params[:commentable_type]).find(params[:commentable_id])
    @comment = Comment.new(commentable: commentable)
  end

  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      flash[:notice] = "Successfully created a comment"
      # TODO: If you add comments to anything other than a blog post, this'll need to be more generic
      redirect_to blog_post_path(@comment.commentable, blog_id: @comment.commentable.blog)
    else
      @error_object = @comment
      render action: "new"
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    parent = comment.commentable
    if comment.can_edit?(current_user)
      if comment.update_attributes(active: false)
        flash[:notice] = "Deleted comment"
      else
        flash[:error] = "Sorry, unable to delete that comment"
      end
    else
      flash[:error] = "Sorry, you don't have permissions to delete that comment"
    end
    # TODO: If you add comments to anything other than a blog post, this'll need to be more generic
    redirect_to blog_post_path(parent, blog_id: parent.blog)
  end
end
