class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_normal_user, only: %i[update destroy]
  skip_before_action :address_empty

  def create
    # super
    devise_create
  end

  def update
    # super
    devise_update
  end

  def destroy
    # super
    devise_destroy
  end

  def devise_create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :success, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :success, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def devise_update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?
      redirect_to user_path(current_user), success: 'プロフィールを更新しました'
    else
      flash.now[:danger] = 'プロフィールの更新に失敗しました'
      render :edit
    end
  end

  def devise_destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message! :success, :destroyed
    yield resource if block_given?
    respond_with_navigational(resource) { redirect_to after_sign_out_path_for(resource_name) }
  end

  def ensure_normal_user
    return if current_user.email != 'guestuser@example.com'

    redirect_to edit_account_path, danger: 'ゲストユーザーは更新・削除できません。'
  end

  protected

  def after_sign_up_path_for
    edit_account_path
  end

  def after_inactive_sign_up_path_for(resource)
    scope = Devise::Mapping.find_scope!(resource)
    router_name = Devise.mappings[scope].router_name
    context = router_name ? send(router_name) : self
    context.respond_to?(:new_user_registration_path) ? context.new_user_registration_path : '/signup'
  end

  def after_logout_path_for
    new_user_session_path
  end

  # ユーザー更新時にパスワードのパラメーターは除外する
  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
