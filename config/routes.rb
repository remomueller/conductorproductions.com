Rails.application.routes.draw do

  resources :projects
  get '/index' => 'welcome#index'
  get '/work' => 'welcome#work'
  get '/drtv' => 'welcome#drtv'
  get '/contact' => 'welcome#contact'
  get '/news' => 'welcome#news'

  get '/about' => 'welcome#about'
  get '/clients' => 'welcome#clients'

  get '/index_v2' => 'welcome#index'
  get '/index_v1' => 'welcome#index_v1'

  scope module: 'welcome' do
    get :dashboard
  end

  scope module: 'application' do
    get :version
  end

  devise_for :users, path_names: { sign_up: 'join', sign_in: 'login' }, path: ""

  root 'welcome#index'

end
