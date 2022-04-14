class Users::RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
  end

  protected

  def after_sign_up_path_for
    #TODO リダイレクト先をプロフィール変更ページへ
    root_path
  end

  def after_logout_path_for
    new_user_session_path
  end
end
