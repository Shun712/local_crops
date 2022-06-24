class Users::SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    super
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

  protected

  def after_sign_in_path_for(resource)
    crops_path
  end
end
