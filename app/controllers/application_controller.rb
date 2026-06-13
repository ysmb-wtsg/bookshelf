class ApplicationController < ActionController::Base
  before_action :require_login
  add_flash_types :success, :danger

  private

  #ログインを必須にする
  def require_login
    unless logged_in?
      redirect_to login_path, alert: 'ログインしてください'
    end
  end

  # ログイン中のユーザーを取得
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  #ログインしているか判定
  def logged_in?
    current_user.present?
  end
  helper_method :logged_in?
end
