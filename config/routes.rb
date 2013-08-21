StacksOnStacks::Application.routes.draw do

  devise_for :users
  get "search", to: "search#index"
  root :to => "pages#home"

end
