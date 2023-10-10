class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :set_post_author, only: %i[edit update destroy]

  # GET /posts
  def index
    # TODO: show posts from current_user and friends
    @posts = Post.all
  end

  # GET /posts/1
  def show; end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts
  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to post_url(@post), notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to post_url(@post), notice: 'Post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy

    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def set_post_author
    render_403 if @post.author != current_user
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
