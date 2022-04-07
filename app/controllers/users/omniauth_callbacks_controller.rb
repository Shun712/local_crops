class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def line
    basic_action
  end

  def twitter
    basic_action
  end

  private

  def basic_action
    @omniauth = request.env['omniauth.auth']
    if @omniauth.present?
      @profile = SocialProfile.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first
      if @profile
        @profile.set_values(@omniauth)
        sign_in(:user, @profile.user)
      else
        @profile = SocialProfile.new(provider: @omniauth['provider'], uid: @omniauth['uid'])
        email = @omniauth['info']['email'] || Faker::Internet.email
        @profile.user = current_user || User.create!(email: email, username: @omniauth['info']['name'], password: Devise.friendly_token[0, 20])
        @profile.set_values(@omniauth)
        sign_in(:user, @profile.user)
      end
    end
    redirect_to root_path, success: 'ログインしました。'
  end
end
