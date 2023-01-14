Rails.application.routes.draw do

  namespace :public do
    resources :customers, only: [:show, :edit, :update] do
      get '/customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
      patch '/customers/:id/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
    end
    resources :order_informations, only: [:new, :show, :index, :create, :update] do
      post '/confirm' => 'order_informations#confirm', as: 'confirm'
      get '/complete' => 'order_informations#complete', as: 'complete'
    end
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      delete 'cart_items' => 'cart_items#destroy_all', as: 'destroy_all'
    end
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :items, only: [:index, :show]
  end

  namespace :admin do
    resources :order_details, only: [:show, :edit, :update, :index]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:show, :edit, :update, :index]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :order_informations, only: [:index, :show, :update]
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