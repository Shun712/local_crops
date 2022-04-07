class ApplicationController < ActionController::Base
  # フラッシュメッセージのキーを許可する
  add_flash_types :success, :info, :warning, :danger
end
