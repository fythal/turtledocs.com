Rails3BootstrapDeviseCancan::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  get "equipment/index"
  # get "equipment/new"
  #get "contact/index"
  root :to => "static_pages#home"
  devise_for :users
  resources :users
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'contact#index'
  match '/equipment', to: 'equipment#index'
  #match '/equipment', to: 'equipment#/new'
  match 'equipment/add' => 'equipment#add', :as => :equipment_add
  match '/equipment/update' => 'equipment#update'
  match '/getmodeldata/:id', to: 'equipment#get_model'
  match '/equipment/create/:name', to: 'equipment#create'
  match '/getequipmentlist/:id', to: 'equipment#get_equipment_list'
end