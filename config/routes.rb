Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # Deviseのマッピングはするが、skipして何も設定しない
  devise_for :users, skip: %i[sessions registrations],
                     controllers: {
                       confirmations: 'users/confirmations',
                       omniauth_callbacks: 'users/omniauth_callbacks',
                       passwords: 'users/passwords'
                     }
  devise_scope :user do
    get 'login', to: 'users/sessions#new', as: :new_user_session
    post 'login', to: 'users/sessions#create', as: :user_session
    post 'guest_login', to: 'users/sessions#guest_login', as: :guest_session
    delete 'logout', to: 'users/sessions#destroy', as: :destroy_user_session
    get 'signup', to: 'users/registrations#new', as: :new_user_registration
    post 'signup', to: 'users/registrations#create', as: :user_registration
    get 'account/edit', to: 'users/registrations#edit', as: :edit_account
    put 'account', to: 'users/registrations#update', as: :account
    delete 'account', to: 'users/registrations#destroy', as: :destroy_account
  end
  root 'static_pages#top'
  get 'about', to: 'static_pages#about'
  get 'terms', to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'
  resources :feedbacks, only: %i[new create]
  resources :crops do
    collection do
      get :search
    end
  end
  resources :users, only: %i[show]
  namespace :mypage do
    get 'following', to: 'relationships#following'
    get 'follower', to: 'relationships#follower'
    resources :notifications, only: %i[index]
  end
  resources :reservations, only: %i[index new create destroy]
  resources :bookmarks, only: %i[index create destroy]
  resources :relationships, only: %i[create destroy]
  resources :chatrooms, only: %i[index create show], shallow: true do
    resources :chats
  end
  resources :notifications, only: [] do
    patch :read, on: :member
    patch :read_all, on: :collection
  end
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
