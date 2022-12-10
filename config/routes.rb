Rails.application.routes.draw do
  namespace :public do
    resources :customers, only: [:show, :edit, :update, :unsubscribe, :withdrawal]
    resources :order_informations, only: [:new, :show, :index, :create, :confirm]
    resources :cart_items, only: [:index, :update, :destroy, :destroy_all, :create]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :items, only: [:index, :show]
  end

  namespace :admin do
    resources :order_details, only: [:show, :update]
    resources :genres, only: [:index, :new, :create, :show, :edit, :update]
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'homes/top'
  root to: "homes#top"

  get 'homes/about' => 'homes#about', as: "about"

end