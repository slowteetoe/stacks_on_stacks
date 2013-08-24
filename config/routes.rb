StacksOnStacks::Application.routes.draw do

  resources :questions do
    resources :answers
    resources :comments
  end

  resources :profiles
  devise_for :users
  resources :users
  
  get '/search' => 'search#index'
  root :to => 'questions#index'
  get '/faq' => 'pages#faq'

end
