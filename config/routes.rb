StacksOnStacks::Application.routes.draw do

  resources :questions do
  	resources :answers
  end

  devise_for :users
  get '/users' => 'users#index'
  get '/users/:id' => 'users#show'
  get '/search' => 'search#index'

  root :to => 'questions#index'
  get '/faq' => 'pages#faq'

end
