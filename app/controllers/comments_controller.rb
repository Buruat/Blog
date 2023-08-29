class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to root_path, notice: 'Комментарий успешно создан'
    else
      redirect_to root_path, alert: 'Коментарий недопустим'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
