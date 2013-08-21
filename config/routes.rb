StacksOnStacks::Application.routes.draw do

  get "search", to: "search#index"
  devise_for :users
  root :to => "pages#home"

end
