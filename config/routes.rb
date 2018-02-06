Rails.application.routes.draw do


  resources :identities
  resources :common_tasks
  resources :neighborhoods
  resources :extracurricular_activities
  resources :talents
  resources :schools
  resources :cohorts
  resources :cohortians, only: [:create, :destroy]
  resources :graduating_classes
  resources :network_actions
  resources :programs
  resources :tasks, only: [:new, :create, :index, :update, :destroy]
  resources :projects

  resources :network_events do
    resources :sign_ups, only: [:new, :show, :create, :edit, :update]
    resources :check_ins, only: [:new, :show, :create]
    collection do
      resources :sign_ups, only:[:index]
      resources :check_ins, only:[:index]
    end
  end

  get 'sign_up', to: 'sign_ups#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  resources :users, only: [:index, :show, :edit, :update, :destroy]

  get 'welcome/index'
  get 'dashboards/index'

  root 'dashboards#index' 

  resources :members do
    resources :communications, only: [:new, :show, :create, :edit, :update, :destroy]
    collection do
      get 'new_in_group'
    end
  end

  resources :locations
  resources :organizations
  resources :participations, only: :destroy

end
