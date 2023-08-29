class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[show update edit destroy]
  before_action :check_user, only: %i[update edit destroy]

  def index
    if params[:filter] == 'Все посты'
      @posts = Post.paginate(page: params[:page], per_page: 4)
    elsif params[:filter] == 'Мои посты'
      if current_user == nil
        redirect_to new_user_session_path, alert: 'Войдите в аккаунт для продолжения'
      else
        @posts = current_user.posts.paginate(page: params[:page], per_page: 4)
      end
    else
      @posts = Post.paginate(page: params[:page], per_page: 4)
    end
  end


  def new
    @post = Post.new
  end

  def create
    params[:post][:user_id] = current_user.id
    @post = Post.create(post_params)
    if @post.save
      redirect_to root_path, notice: "Пост успешно создан"
    else
      redirect_to new_post_path, alert: "Неверные данные"
    end
  end

  def show
    @current_user = current_user
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path, notice: "Пост успешно обновлен"
    else
      redirect_to edit_post_path, alert: "Неверные данные"
    end
  end

  def destroy
    @post.destroy

    redirect_to root_path, notice: "Пост успешно удален"
  end

  private
  def post_params
    params.require(:post).permit(:title,:body, :description,:user_id, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def check_user
    if current_user.id != set_post.user_id
      redirect_to root_path, alert: "Это не ваш пост"
    end
  end
end
