Rails.application.routes.draw do
  resources :programs
  resources :network_events
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  
  devise_for :users
  
  get 'welcome/index'

  root 'welcome#index'
  
  resources :members
  resources :locations
  
end
