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
  def after_confirmation_path_for(resource_name, resource)
    sign_in(resource)
    root_path
  end
end