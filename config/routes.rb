Rails.application.routes.draw do
  root to: 'contacts#index'
  resources :contacts, except: %i[show]
  get 'contacts/:slug', to: 'contacts#show'
end