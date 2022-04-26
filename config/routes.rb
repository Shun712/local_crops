Rails.application.routes.draw do
  # Deviseのマッピングはするが、skipして何も設定しない
  devise_for :users, skip: %i[sessions registrations passwords],
                     controllers: {
                       confirmations: 'users/confirmations',
                       omniauth_callbacks: 'users/omniauth_callbacks'
                     }
  devise_scope :user do
    get 'login', to: 'users/sessions#new', as: :new_user_session
    post 'login', to: 'users/sessions#create', as: :user_session
    delete 'logout', to: 'users/sessions#destroy', as: :destroy_user_session
    get 'signup', to: 'users/registrations#new', as: :new_user_registration
    post 'signup', to: 'users/registrations#create', as: :user_registration
    get 'password', to: 'users/passwords#new', as: :new_user_password
    post 'password', to: 'users/passwords#create', as: :user_password
    get 'password/edit', to: 'users/passwords#edit', as: :edit_user_password
  end
  root 'crops#index'
  get 'about', to: 'static_pages#about'
  get 'terms', to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'
  resources :feedbacks, only: %i[new create]
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
