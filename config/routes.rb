StacksOnStacks::Application.routes.draw do

  resources :profiles

  resources :questions
  root :to => 'questions#index'

  devise_for :users
  resources :users
  # get '/users' => 'users#index'
  # get '/users/:id' => 'users#show'
  get '/search' => 'search#index'

  get '/faq' => 'pages#faq'

end
