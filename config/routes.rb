StacksOnStacks::Application.routes.draw do

  resources :questions do
    resources :answers
  end

  devise_for :users
  resources :users, only: [:index, :show]
  resources :profiles, only: [:edit, :update]
  resources :comments

  get 'tags' => 'questions#tags'
  get 'tagged/:tag' => 'questions#tagged'

  post '/questions/:id/upvote' => 'questions#upvote'
  post '/questions/:id/downvote' => 'questions#downvote'
  get '/questions/:id/remove_vote' => 'questions#remove_vote'

  post '/answers/:id/upvote' => 'answers#upvote'
  post '/answers/:id/downvote' => 'answers#downvote'
  get '/answers/:id/remove_vote' => 'answers#remove_vote'

  get '/search' => 'search#index'
  root :to => 'questions#index'
  get '/faq' => 'pages#faq'

end
