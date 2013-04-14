Rails3BootstrapDeviseCancan::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "static_pages#home"
  devise_for :users
  resources :users
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
end