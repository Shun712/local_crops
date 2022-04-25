class UserMailer < ApplicationMailer
  def feedback
    @user_from = params[:user_from]
    @feedback = params[:feedback]
    mail(to: "user@example.com", subject: "#{@user_from.username}さんからお問い合わせをいただきました")
  end
end
