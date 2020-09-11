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
end
