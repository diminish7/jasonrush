class BlogsController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update, :new, :create, :delete]

  # List all blogs
  def index
    @blogs = Blog.all
  end

  def show
    redirect_to blog_posts_path(Blog.find(params[:id]))
  end

  def menu
    @blog = Blog.find(params[:id])
    respond_to do |format|
      format.html
      format.json do
        render json: {
          blog: @blog,
          recent: @blog.posts.recent,
          months: @blog.possible_months
        }
      end
    end
  end

  # Support links from the old blogger URLs
  def blogger_index
    flash[:notice] = "The URL has changed, please update your bookmarks"
    redirect_to blog_posts_path(blog_id: "dev")
  end

  def blogger_post
    flash[:notice] = "The URL has changed, please update your bookmarks"
    redirect_to blog_post_path(params[:id], blog_id: "dev")
  end
end
