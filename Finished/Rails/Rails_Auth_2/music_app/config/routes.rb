Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: redirect('/bands')

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :index] do
    get :verify, on: :collection

    member do
      get :admin
    end
  end

  resources :bands do
    resources :albums, only: :new
  end

  resources :albums, except: [:new, :index] do
    resources :tracks, only: :new
  end

  resources :tracks, except: [:new, :index]

  resources :notes, only: [:create, :destroy]
end
