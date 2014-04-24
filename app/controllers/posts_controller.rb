class PostsController < ApplicationController
  before_filter :get_support_data, only: [:index, :show]
  before_filter :authenticate_user!, only: [:update, :create, :destroy]

  respond_to :xml, only: [:rss, :atom]
  respond_to :json, only: [:update, :create, :destroy]

  def index
    @blog = Blog.find(params[:blog_id], include: :posts)
    @month = params[:month]
    @year = params[:year]
    @posts = if @month && @year
      @blog.posts.ordered.for_year(@year).for_month(@month)
    else
      @blog.posts.ordered.limit(5) if @blog
    end
    # Fill posts with a default post if there aren't any
    @posts = [Post.no_posts(@blog, User.find_by_email('jasonrush@jasonrush.com'))] if @posts.blank?
    respond_to do |format|
      format.html
      format.json do
        render json: {
          blog: @blog,
          month: @month,
          year: @year,
          posts: @posts
        }
      end
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json do
        render json: {
          blog: @blog,
          post: @post
        }
      end
    end
  end

  def create
    blog = Blog.find(params[:blog_id])
    post = Post.new(params[:post].merge(author: current_user, blog: blog))
    response = post.save ? post.as_json : { error: post.errors.full_messages.join(', ') }
    render json: response
  end

  def rss
    @blog = Blog.find(params[:blog_id], include: :posts)
    render layout: false
    response.headers["Content-Type"] = "application/rss+xml"
  end

protected
  def get_support_data
    @blog = Blog.find(params[:blog_id], include: :posts)
    @post = Post.find(params[:id], include: :blog) if params[:id]
    raise "'#{@post.title}' does not belong to the blog '#{@blog.name}'" unless @post.nil? || @blog.posts.include?(@post)
  end
end
