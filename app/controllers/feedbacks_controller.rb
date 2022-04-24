class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = current_user.feedbacks.build(feedback_params)
    if @feedback.save
      redirect_to new_feedback_path, success: 'フィードバックを送信しました。'
    else
      flash.now[:danger] = '送信に失敗しました。'
      render :new
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:body).merge(user_id: params[:user_id])
  end
end
