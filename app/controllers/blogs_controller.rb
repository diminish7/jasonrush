class BlogsController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update, :new, :create, :delete]

  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
    authorize @blog
    redirect_to blog_posts_path(@blog)
  end

  def menu
    @blog = Blog.find(params[:id])
    authorize @blog, :show?
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
