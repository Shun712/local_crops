class UserMailer < ApplicationMailer
  def feedback
    @user_from = params[:user_from]
    @feedback = params[:feedback]
    mail(to: ENV['GMAIL_ADDRESS'], subject: "【お問い合わせ】")
  end
end
