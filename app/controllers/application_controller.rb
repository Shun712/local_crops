class ApplicationController < ActionController::Base
  # フラッシュメッセージのキーを許可する
  add_flash_types :success, :info, :warning, :danger
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_search
  before_action :address_empty

  def set_search
    @search_word = params[:q][:name_or_description_cont] if params[:q]
    @q = Crop.ransack(params[:q])
  end

  def address_empty
    return if current_user.address?

    redirect_to edit_account_path, danger: '住所を登録してください'
  end

  protected

  def configure_permitted_parameters
    # user登録でユーザー名を登録できるようにする
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    # user更新でユーザー名、メールアドレス、アバター画像、住所を更新できるようにする
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username email avatar postcode address latitude longitude])
  end
end
