Rails.application.routes.draw do
  # 目前這個 app 只打算讓少部分人登入使用
  devise_for :users, only: :sessions
  root to: 'uploads#new'
  resources :uploads, only: [:new, :create, :index]
end
