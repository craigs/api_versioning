Dummy::Application.routes.draw do
  resources :posts
  get 'error' => 'posts#error', :as => :error
end
