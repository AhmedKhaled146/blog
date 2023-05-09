class BlogPostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def index
    @blogs = BlogPost.all
    @blog_count = BlogPost.count
  end

  def show
  end

  def new
    @blog = BlogPost.new
  end

  def create
    @blog = BlogPost.new(blog_params)
    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: "#{@blog.title} Was created." }
        format.json { render :show, status: :created}
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    @blog.update(blog_params)
    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: "#{@blog.title} was updated" }
        format.json { render :show, status: :updated }
      else
        format.html { render :edit, status: :unprocessable_entity}
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end

    end

  end

  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: "#{@blog.title} was deleted"}
      format.json { head :no_content }
    end
  end


  private

  def blog_params
    params.require(:blog_post).permit(:title, :body)
  end

  def set_blog
    @blog = BlogPost.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def authenticate_user!
    redirect_to new_user_session_path, alert: "You must sign in" unless user_signed_in?

  end


end
