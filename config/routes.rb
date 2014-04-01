Jasonrush::Application.routes.draw do
  devise_for :users

  root to: "dashboard#index"
  match '/index.json', to: 'dashboard#index', defaults: { format: 'json' }

  resources :blogs do
    resources :posts do
      collection do
        get :rss
      end
    end
    member do
      get :menu
    end
  end

  resources :users
end
