class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  #ログインしていない場合
  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインして！"
      redirect_to("/login");
    end
  end

  #すでにログイン済みの場合
  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしてるよー！"
      redirect_to("/posts/index")
    end
  end

end
