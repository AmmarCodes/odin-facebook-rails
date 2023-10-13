class CommentsController < ApplicationController
  before_action :set_post, only: %i[create destroy]
  # before_action :set_comment, only: %i[show edit update destroy like dislike]

  # POST /posts/:id/comments
  def create
    @comment = @post.comments.build(comments_params.merge({ user: current_user }))

    if @comment.save
      redirect_to post_url(@post), notice: 'Comment was successfully added.'
    else
      redirect_to post_url(@post), notice: 'Comment could not be added.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:post_id])
  end

  def comments_params
    params.permit(:content)
  end
end
