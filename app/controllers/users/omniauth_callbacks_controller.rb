class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :address_empty

  def line
    basic_action :line
  end

  def twitter
    basic_action :twitter
  end

  private

  def basic_action(provider)
    provider = provider.to_s
    user = User.find_for_oauth!(auth_params)
    if user.present?
      sign_in(:user, user)
      redirect_to crops_path, success: 'ログインしました。'
    else
      user = User.sign_up(auth_params)
      sign_in(:user, user)
      flash[:success] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      redirect_to edit_account_path
    end
  end

  def auth_params
    request.env['omniauth.auth']
  end
end
