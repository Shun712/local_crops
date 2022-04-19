class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def line
    basic_action :line
  end

  def twitter
    basic_action :twitter
  end

  private

  def basic_action(provider)
    unless auth_params
      flash[:danger] = "認証に失敗しました。他の方法をお試しください。"
      redirect_to new_user_session_path && return
    end
    provider = provider.to_s
    user = User.find_for_oauth!(auth_params)
    if user.present?
      sign_in(:user, user)
      redirect_to root_path, success: 'ログインしました。'
    else
      user = User.create(auth_params)
      sign_in(:user, user)
      #TODO リダイレクト先をプロフィール変更ページへ
      flash[:success] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      redirect_to root_path
    end
  end

  def auth_params
    request.env['omniauth.auth']
  end
end
