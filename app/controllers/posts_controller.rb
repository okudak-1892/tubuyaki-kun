class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user , {only: [:edit,:update,:destroy]}

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
  end

  def new
    @post = Post.new
  end

  #新規つぶやき
  def create
    @post = Post.new(content: params[:content] ,user_id: @current_user.id)
    if @post.save
      flash[:notice] = "つぶやきかんりょー！"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  #つぶやきを編集
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save 
      flash[:notice] = "更新かんりょー！"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end

  #つぶやきを削除
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "削除かんりょー！"
    redirect_to("/posts/index")
  end

  #つぶやきの編集権限を設定
  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "編集権限は君にはないよ！"
      redirect_to("/posts/index")
    end
  end

end
