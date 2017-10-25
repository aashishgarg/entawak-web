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
      get :team_assigmnent
    end
  end

  resources :students do
    collection do
      get :welcome
      get :game
    end
  end
end
