class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def new
    super
  end

  def create
    super
  end

  protected

  def after_sign_up_path_for
    root_path
  end

  def after_logout_path_for
    new_user_session_path
  end
end