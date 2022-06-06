class ApplicationController < ActionController::Base
  # フラッシュメッセージのキーを許可する
  add_flash_types :success, :info, :warning, :danger
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    # user登録でユーザー名を登録できるようにする
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    # user更新でユーザー名、メールアドレス、アバター画像、住所を更新できるようにする
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username email avatar postcode address latitude longitude])
  end
end
