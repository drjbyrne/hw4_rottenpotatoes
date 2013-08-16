Rottenpotatoes::Application.routes.draw do
  resources :movies do
    member do
      get 'similar'
    end
  end
end
