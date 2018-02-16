Rails.application.routes.draw do
  
  get '/search', to: 'cryptos#search'

  root 'cryptos#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
