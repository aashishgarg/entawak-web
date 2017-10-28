Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  mount ActionCable.server => "/cable"

  get 'games/introduction'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'games#dashboard'

  devise_for :teachers, controllers: {
      registrations: 'teachers/registrations',
      sessions: 'teachers/sessions',
      password: 'teachers/password'
  }

  resources :games do
    member do
      get :active_students
      get :start
      get :change_audio
      get :switch
      get :pause
    end
    collection do
      get :help
      post :help
      get :dashboard
    end
  end

  resources :students do
    collection do
      get :welcome
      get :game
      get :time_up
    end
  end
  resources :questions, only: [:show] do
    member do
      post :submit
    end
  end

  resources :teams, only: [:show] do
    member do
      get :question
      get :scream
      get :game_over
    end
    collection do
      get :assign
    end
  end
end
