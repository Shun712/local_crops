class Users::SessionsController < Devise::SessionsController
  skip_before_action :address_empty

  def create
    # super
    devise_create
  end

  def devise_create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:success, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  def destroy
    # super
    devise_destroy
  end

  def devise_destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :success, :signed_out if signed_out
    yield if block_given?
    respond_to_on_destroy
  end

  def guest_login
    user = User.guest
    sign_in user
    redirect_to crops_path, success: 'ゲストユーザーとしてログインしました'
  end

  protected

  def after_sign_in_path_for(_resource)
    crops_path
  end
end
