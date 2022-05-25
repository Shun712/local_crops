module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    # current_userをWebsocket側で使う
    def connect
      reject_unauthorized_connection unless find_verified_user
    end

    private

    def find_verified_user
      # Deviseを使っている場合、ログインユーザーのインスタンスには以下でアクセスできる
      self.current_user = env['warden'].user
    end
  end
end
