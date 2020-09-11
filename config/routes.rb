Rails.application.routes.draw do
  devise_for :users, controllers:{
    registrations: "users/registrations"
  }
  devise_scope :user do
    get 'users/registrations/admin_signup' => 'users/registrations#admin_new'
    post "users/registrations/admin_create" => "users/registrations#admin_create"
  end
  get 'homes/index'
  root "homes#index"
  resources :teams, only: [:new, :create, :show, :edit, :update]

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