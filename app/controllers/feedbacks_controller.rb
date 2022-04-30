class FeedbacksController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      UserMailer.with(user_from: @feedback.name,
                      feedback: @feedback).feedback.deliver_later
      redirect_to new_feedback_path, success: 'お問い合わせ内容を送信しました。'
    else
      flash[:danger] = '送信に失敗しました。'
      redirect_to new_feedback_path
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:name, :email, :body)
  end
end
