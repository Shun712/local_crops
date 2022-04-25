class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = current_user.feedbacks.build(feedback_params)
    if @feedback.save
      UserMailer.with(user_from: current_user,
                      feedback: @feedback).feedback.deliver_later
      redirect_to new_feedback_path, success: 'お問い合わせ内容を送信しました。'
    else
      flash[:danger] = '送信に失敗しました。'
      redirect_to new_feedback_path
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:body).merge(user_id: params[:user_id])
  end
end
