StacksOnStacks::Application.routes.draw do

  get "search", to: "search#index"
  root :to => "pages#home"

end
