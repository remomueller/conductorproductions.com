Rails.application.routes.draw do

  resources :projects do
    member do
      get :menu
      get :agency_logo
      get :client_logo
    end

    resources :categories

    resources :documents do
      member do
        get :download
      end
    end
  end

  scope module: 'welcome' do
    get :dashboard
    get :index
    get :work
    get :drtv
    get :contact
    post :submit_contact
    get :news
    get :about
    get :clients
    get :index_v2
    get :index_v1
  end

  scope module: 'application' do
    get :version
  end

  scope module: 'client_session' do
    get  "client/login",  action: 'new',     as: :client_login
    post "client/login",  action: 'create'
    get  "client/logout", action: 'destroy', as: :client_logout
  end

  devise_for :users, path_names: { sign_up: 'join', sign_in: 'login', sign_out: 'logout' }, path: ""

  scope module: 'client_project' do
    get ":id", action: 'root', as: :client_project_root
    get ":id/menu", action: 'menu', as: :client_project_menu
    get ":id/agency_logo", action: 'agency_logo', as: :client_project_agency_logo
    get ":id/client_logo", action: 'client_logo', as: :client_project_client_logo

    get ":id/documents/download/:document_id", action: 'download_document', as: :client_project_download_document
    get ":id/:top_level/:category_id", action: 'category', as: :client_project_category
    get ":id/:top_level/:category_id/:document_id", action: 'document', as: :client_project_category_document
    get ":id/:category_id", action: 'category'
  end

  root 'welcome#index'

end
