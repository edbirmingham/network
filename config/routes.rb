Rails.application.routes.draw do
  resources :neighborhoods
  resources :talents
  resources :schools
  resources :cohorts
  resources :graduating_classes
  resources :network_actions
  resources :programs
  resources :network_events
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :users, only: [:index, :show, :edit, :update, :destroy]

  get 'welcome/index'

  root 'welcome#index'

  resources :members
  resources :locations
  resources :organizations
end
