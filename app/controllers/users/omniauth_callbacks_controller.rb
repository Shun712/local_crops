class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def line
    basic_action :line
  end

  def twitter
    basic_action :twitter
  end

  private

  def basic_action(provider)
    provider = provider.to_s
    user = User.find_for_oauth!(request.env['omniauth.auth'])
    if user.present?
      sign_in(:user, user)
      redirect_to root_path, success: 'ログインしました。'
      redirect_to root_path
    else
      user = User.create(request.env['omniauth.auth'])
      sign_in(:user, user)
      #TODO リダイレクト先をプロフィール変更ページへ
      flash[:success] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      redirect_to root_path
    end
  end
end
