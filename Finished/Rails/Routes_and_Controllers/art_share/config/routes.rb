# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :users

  resources :users, only: %i[index create show update destroy] do
    resources :artworks, only: :index
    resources :collections, only: :index
    get 'favorites'
  end

  resources :artworks, only: %i[create show update destroy] do
    member do
      post :like, to: 'artworks#like', as: 'like'
      delete :unlike, to: 'artworks#unlike', as: 'unlike'
      post :favorite, to: 'artworks#favorite', as: 'favorite'
      post :unfavorite, to: 'artworks#unfavorite', as: 'unfavorite'
    end
  end

  resources :artwork_shares, only: %i[create destroy] do
    member do
      post :favorite, to: 'artwork_shares#favorite', as: 'favorite'
      post :unfavorite, to: 'artwork_shares#unfavorite', as: 'unfavorite'
    end
  end

  resources :comments, only: %i[index create destroy] do
    member do
      post :like, to: 'comments#like', as: 'like'
      delete :unlike, to: 'comments#unlike', as: 'unlike'
    end
  end

  resources :collections, only: %i[create show destroy] do
    resources :artworks, only: :index do
      post :add, to: 'collections#add_artwork', as: 'add'
      delete :remove, to: 'collections#remove_artwork', as: 'remove'
    end
  end
end
