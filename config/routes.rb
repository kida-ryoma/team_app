Rails.application.routes.draw do
  devise_for :users, controllers:{
    registrations: "users/registrations"
  }

  devise_scope :user do
    get 'users/registrations/admin_signup' => 'users/registrations#admin_new'
    post "users/registrations/admin_create" => "users/registrations#admin_create"
    post "users/guest_sign_in", to: "users/sessions#new_guest"
  end

  get 'homes/index'
  root "homes#index"

  resources :users, only: :show

  resources :teams do
    resources :notifications, only: :index
    resources :games do
      member do
        resources :game_results, only: [:new, :create]
      end
      member do
        post "send_remind"
      end
      resources :games_users, only: [:edit, :update] do
        member do
          patch "update_no"
        end
      end
    end
    member do
      get "main"
      get "add_user"
      post "create_user"
      post "send_mail"
      get "put_mail"
    end
  end

  resources :messages, only: [:create]

  resources :rooms, only: [:index, :create, :show]
end

def devise_scope(scope)
  constraint = lambda do |request|
    request.env["devise.mapping"] = Devise.mappings[scope]
    true
  end

  constraints(constraint) do
    yield
  end
end