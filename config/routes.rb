Rails.application.routes.draw do
  resources :talents
  resources :schools
  resources :cohorts
  resources :graduating_classes
  resources :network_actions
  resources :programs
  resources :network_events
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  devise_for :users
  resources :users, only: [:index, :show, :destroy]

  get 'welcome/index'

  root 'welcome#index'

  resources :members
  resources :locations
  resources :organizations
end
