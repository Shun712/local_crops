class Mypage::NotificationsController < Mypage::BaseController
  def index
    @notifications = current_user.notifications.order(created_at: :desc).page(params[:page]).per(12)
  end
end
