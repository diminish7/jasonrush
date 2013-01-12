class PostsController < ApplicationController
  before_filter :get_support_data, only: [:index, :show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:edit, :update, :new, :create, :destroy]

  respond_to :html, except: [:rss, :atom]
  respond_to :xml, only: [:rss, :atom]

  def index
    @blog = Blog.find(params[:blog_id], include: :posts)
    @month = params[:month]
    @year = params[:year]
    @posts = if @month && @year
      @blog.posts.ordered.for_year(@year).for_month(@month)
    else
      @blog.posts.ordered[0..10] if @blog
    end
  end

  def rss
    @blog = Blog.find(params[:blog_id], include: :posts)
    render layout: false
    response.headers["Content-Type"] = "application/rss+xml"
  end

  def show
  end

  def edit
  end

  def update
    raise "Can't change blogs in mid-stream!!" unless @blog.id == @post.blog_id.to_i
    if !@post.can_edit?(current_user)
      flash[:error] = "Sorry, you done't have permission to edit this post!"
      redirect_to blog_post_path(@post, blog_id: @blog)
    elsif @post.update_attributes(params[:post])
      flash[:notice] = "Successfully created the post '#{@post.title}'"
      redirect_to blog_post_path(@post, blog_id: @blog)
    else
      @error_object = @post
      render action: "edit"
    end
  end

  def new
    @blog = Blog.find(params[:blog_id])
    raise "Can't create a post without a blog!" unless @blog
    @post = Post.new(blog: @blog)
  end

  def create
    @blog = Blog.find(params[:blog_id])
    raise "Can't create a post without a blog!" unless @blog
    @post = Post.new(params[:post])
    raise "Can't change blogs in mid-stream!!" unless @blog.id == @post.blog_id.to_i
    if @post.save
      flash[:notice] = "Successfully created the post '#{@post.title}'"
      redirect_to blog_post_path(@post, blog_id: @blog)
    else
      @error_object = @post
      render action: "new"
    end
  end

  def destroy
    if @post.can_edit?(current_user) && @post.destroy
      flash[:notice] = "Successfully destroy the post '#{@post.title}'"
      redirect_to blog_posts_path(blog_id: @blog)
    else
      flash[:error] = "Woops! Something went wrong, couldn't delete the post '#{@post.title}'"
      redirect_to blog_post_path(@post, blog_id: @blog)
    end
  end

protected
  def get_support_data
    @blog = Blog.find(params[:blog_id], include: :posts)
    @post = Post.find(params[:id], include: :blog) if params[:id]
    raise "'#{@post.title}' does not belong to the blog '#{@blog.name}'" unless @post.nil? || @blog.posts.include?(@post)
    # Show the most recent 10 posts - if we are on a post, show the previous 10
    @next_posts = Post.limit(10).order("created_at desc").where(blog_id: @blog.id)
    @next_posts = @next_posts.where("created_at < ?", @post.created_at) if @post
  end

end
