DragonflyTestRails3::Application.routes.draw do

  resources :users do
    member do
      get :crop
    end
  end

  root :to => "users#index"

end
