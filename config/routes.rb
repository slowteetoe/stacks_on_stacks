StacksOnStacks::Application.routes.draw do

  resources :profiles

  resources :questions do
    resources :answers
  end

  devise_for :users
  
  resources :users
  
  get '/search' => 'search#index'

  root :to => 'questions#index'
  get '/faq' => 'pages#faq'

end
