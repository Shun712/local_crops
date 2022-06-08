class Users::ConfirmationsController < Devise::ConfirmationsController
  def new
    super
  end

  def create
    super
  end

  def show
    super
  end

  protected

  # メール認証後のページ遷移先を設定
  def after_confirmation_path_for(_resource_name, resource)
    sign_in(resource)
    edit_mypage_account_path
  end
end
