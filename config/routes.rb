Rails.application.routes.draw do

  mount ActionCable.server => "/cable"

  get 'games/introduction'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_scope :teacher do
    root to: "teachers/sessions#new"
  end

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
    end
  end

  resources :students do
    collection do
      get :welcome
      get :game
    end
  end
  resources :questions, only: [:show] do
    member do
      post :submit
    end
  end

  resources :teams, only: [:show] do
    collection do
      get :assign
    end
  end
end
