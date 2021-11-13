Rails.application.routes.draw do
  get '/', to: 'home#index'
  get '/export', to: 'home#export'
  resources :appointments
  resources :professionals
  resources :patientes
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
