Rails.application.routes.draw do
  get 'network_event_tasks/update'

  resources :identities
  resources :common_tasks
  resources :neighborhoods
  resources :extracurricular_activities
  resources :talents
  resources :schools
  resources :cohorts
  resources :graduating_classes
  resources :network_actions
  resources :programs
  resources :network_event_tasks, only: [:create, :index, :update, :destroy]

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

  root 'welcome#index'

  resources :members do
    resources :communications, only: [:new, :show, :create, :edit, :update, :destroy]
  end

  resources :locations
  resources :organizations
  resources :participations, only: :destroy

end
