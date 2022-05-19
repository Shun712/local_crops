class Mypage::RelationshipsController < Mypage::BaseController
  def following
    @users = current_user.following.page(params[:page]).per(12)
  end

  def follower
    @users = current_user.followers.page(params[:page]).per(12)
  end
end
