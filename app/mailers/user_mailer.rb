class UserMailer < ApplicationMailer
  def feedback
    @user_from = params[:user_from]
    @feedback = params[:feedback]
    mail(to: ENV['GMAIL_ADDRESS'], subject: "#{@user_from.username}さんからお問い合わせ")
  end
end
