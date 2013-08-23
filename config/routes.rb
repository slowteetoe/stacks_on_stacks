StacksOnStacks::Application.routes.draw do

  resources :questions

  devise_for :users
  get '/users' => 'users#index'
  get '/users/:id' => 'users#show'
  get '/search' => 'search#index'
  root :to => 'pages#home'

end
