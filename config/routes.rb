Rails.application.routes.draw do
  # Deviseのマッピングはするが、skipして何も設定しない
  devise_for :users, skip: %i[sessions registrations passwords],
             controllers: {
               confirmations: 'users/confirmations'
             }
  devise_scope :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
    get 'signup', to: 'devise/registrations#new', as: :new_user_registration
    post 'signup', to: 'devise/registrations#create', as: :user_registration
    get 'password', to: 'devise/passwords#new', as: :new_user_password
    post 'password', to: 'devise/passwords#create', as: :user_password
    get 'password/edit', to: 'devise/passwords#edit', as: :edit_user_password
  end
  root 'home#index'
end
