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
  get '/question/:id/upvote' => 'questions#upvote'
  get '/question/:id/downvote' => 'questions#downvote'
  get '/question/:id/remove_vote' => 'questions#remove_vote'

end
