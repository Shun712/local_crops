class NotificationsController < ApplicationController
  def read
    notification = current_user.notifications.find(params[:id])
    notification.read! if notification.unread?
    redirect_to notification.redirect_path
  end

  def read_all
    notifications = current_user.notifications.where(read: "unread")
    notifications.each { |notification| notification.read! }
    redirect_to mypage_notifications_path
  end
end
