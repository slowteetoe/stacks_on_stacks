StacksOnStacks::Application.routes.draw do

  resources :questions do
    resources :answers
  end

  resources :comments
  resources :profiles
  devise_for :users
  resources :users
  
  get '/search' => 'search#index'
  root :to => 'questions#index'
  get '/faq' => 'pages#faq'

  # these should be POST routes once this is working
  post '/questions/:id/upvote' => 'questions#upvote'
  post '/questions/:id/downvote' => 'questions#downvote'
  get '/questions/:id/remove_vote' => 'questions#remove_vote'

end
