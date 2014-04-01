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
end
