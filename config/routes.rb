Jasonrush::Application.routes.draw do
  devise_for :users

  root to: "dashboard#index"

  resources :blogs do
    resources :posts do
      collection do
        get :rss
      end
    end
  end

  resources :comments
  resources :users

  # Support old blogger path
  match '/blog', to: 'blogs#blogger_index'
  match '/blog/:year/:month/:id.:format', to: 'blogs#blogger_post'
  # Support old blogger feeds
  match '/blog/atom.xml', to: 'posts#rss', blog_id: 'dev'
  match '/blog/rss.xml', to: 'posts#rss', blog_id: 'dev'
end
