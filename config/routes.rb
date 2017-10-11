Rails.application.routes.draw do

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
    end
  end

  resources :students do
    collection do
      get :welcome
    end
  end
end
