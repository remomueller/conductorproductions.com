Rails.application.routes.draw do

  resources :projects do
    member do
      get :menu
    end
  end

  scope module: 'welcome' do
    get :dashboard
    get :index
    get :work
    get :drtv
    get :contact
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

  devise_for :users, path_names: { sign_up: 'join', sign_in: 'login' }, path: ""

  scope module: 'client_project' do
    get ":id", action: 'root', as: :client_project_root
    get ":id/menu", action: 'menu', as: :client_project_menu
    get ":id/creative/script", action: 'script', as: :client_project_script
    get ":id/production/casting", action: 'casting', as: :client_project_casting
    get ":id/timeline", action: 'timeline', as: :client_project_timeline

    get ":id/script", action: 'script'
    get ":id/casting", action: 'casting'
  end

  root 'welcome#index'

end
