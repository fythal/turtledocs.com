Rails3BootstrapDeviseCancan::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
    #root :to => 'users#home'
  end
  get "equipment/index"
  # get "equipment/new"
  #get "contact/index"
  root :to => "static_pages#main"
  devise_for :users
  resources :users
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'contact#index'
  match '/equipment', to: 'equipment#index'
  match '/more', to: 'more#index'
  #match '/equipment', to: 'equipment#/new'
  match 'equipment/add' => 'equipment#add', :as => :equipment_add
  match '/equipment/update' => 'equipment#update'
  match '/getmodeldata/:id', to: 'equipment#get_model'
  match '/equipment/create/:name', to: 'equipment#create'
  match '/getequipmentlist/:id', to: 'equipment#get_equipment_list'
  match '/equipment/edit/:id', to: 'equipment#edit'
  match '/equipment/remove', to: 'equipment#remove'
  match '/equipment/docs_container/:equipment_id/:model_id' => 'equipment#docs_container'
  match '/equipment/search_documents' => 'equipment#search_documents'
  match '/equipment/get_search_select/' => 'equipment#get_search_select'
  match '/model/view/:equipment_select_id/:select_model_id', to: 'model#view'
  match '/model/edit/:id', to: 'model#edit'
  match '/model/update' => 'model#update'
  match '/model/add/:equipment_id', to: 'model#add'
  match '/model/create/:name/:equipment_id', to: 'model#create'
  match '/model/remove', to: 'model#remove'
  match '/documents/view/:model_id', to: 'documents#view'
  match '/documents/upload' => 'documents#upload'
  match '/documents/new/:model_id' => 'documents#new'
  match '/documents/get_file/' => 'documents#get_file'
  match '/documents/edit/:id' => 'documents#edit'
  match '/documents/update' => 'documents#update'
  match '/documents/view' => 'documents#view'
  match '/documents/remove' => 'documents#remove'
  match '/documents/save_favorite' => 'documents#save_favorite'
  match '/documents/delete_favorite' => 'documents#delete_favorite'
  match 'logs/get_recent_docs' => 'logs#get_recent_docs'
  match 'doc_viewer/view_doc' => 'doc_viewer#view_doc'
end