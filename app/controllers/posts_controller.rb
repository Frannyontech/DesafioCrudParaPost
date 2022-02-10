class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :do_search, only: :search

  # GET /posts or /posts.json
  def index
    @posts = Post.all
    @posts = Post.new
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
      unless @post.save
      render json: @post.errors, status: :unprocessable_entity 
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
     @post.update(post_params)
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content)
    end

    def do_search
      if params[:q].present?
        @search = Post.searching(params[:q])
      else
        @search = Post.all
      end
    end
end