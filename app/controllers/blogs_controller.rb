class BlogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blog, only: :show
  before_action :set_own_blog, only: [:destroy]

  def index
    @blogs=Blog.all.includes(:user)
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user = current_user
    if @blog.save
      redirect_to blogs_path
    else
      render :new
    end
  end

  def destroy
    if @blog.destroy
      redirect_to blogs_path
    end
  end

  def set_own_blog
    @blog = current_user.blogs.find_by_id(params[:id])
    if @blog.nil?
      flash[:alert] = 'this post not belongs_to you or not exists'
      redirect_to blogs_path
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :description)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end




end
