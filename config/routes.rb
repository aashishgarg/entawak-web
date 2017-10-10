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

  resources :games

  resources :students do
    collection do
      match :welcome, via: [:get, :post]
    end
  end
end
