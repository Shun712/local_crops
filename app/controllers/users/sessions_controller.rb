class Users::SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    super
  end

  def destroy
    super
  end

  protected

  def after_sign_in_path_for(resource)
    crops_path
  end
end
