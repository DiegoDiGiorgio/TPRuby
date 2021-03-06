Rails.application.routes.draw do
  devise_for :users, path: '/', path_names: { 
    sign_in: '', 
    sign_out: 'logout',
    password: 'secret',
    confirmation: 'verification',
    unlock: 'unblock', 
    sign_up: 'cmon_let_me_in' }
  get '/home', to: 'home#index'
  get '/export', to: 'exporter#index'
  post '/export', to: 'exporter#export'
  resources :appointments
  resources :professionals
  resources :patientes
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
