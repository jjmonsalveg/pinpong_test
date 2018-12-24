# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :users
  resources :games, only: %i[index show create]
  get :leader_board, to: 'users#leader_board'
end
