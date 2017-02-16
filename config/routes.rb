# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  get 'pc' => 'pc#index'

  namespace :pc do
    get :clients
    get :contact
    get :index
    get :our_work, path: 'our-work'
    get :director_christian_williams, path: 'directors/christian-williams'
    get :director_kamell_allaway, path: 'directors/kamell-allaway'
    get :director_noah_lydiard, path: 'directors/noah-lydiard'
    get :director_vladimir_minuty, path: 'directors/vladimir-minuty'
  end

  resources :videos do
    collection do
      get 'reorder/:video_page', action: 'reorder', as: :reorder
      post :save_video_order
    end
  end

  resources :projects do
    collection do
      get :archived
    end

    member do
      get :menu
      get :agency_logo
      get :client_logo
      get :collaborators
      post :invite_user
      post :save_category_order
    end

    resources :categories do
      member do
        post :save_gallery_order
      end
    end

    resources :documents do
      member do
        get :download_primary
        get :download
      end
    end

    resources :embeds

    resources :galleries do
      member do
        patch :upload_photos
        post :save_photo_order
      end
      resources :gallery_photos do
        member do
          get :download
        end
      end
    end
  end

  resources :project_users do
    member do
      post :resend
    end
    collection do
      get :accept
    end
  end

  get 'invite/:invite_token' => 'project_users#invite'

  get '2016', to: redirect('year-in-review')
  scope module: 'welcome' do
    get :dashboard
    get :index
    get :work
    get :drtv
    get 'images/videos/:video_id', action: :download_video_image, as: :download_video_image
    get :contact
    post :submit_contact
    get :year_in_review, path: 'year-in-review'
    # get :news
    # get :about
    # get :clients
    # get :index_v1
  end

  scope module: 'application' do
    get :version
  end

  scope module: 'client_session' do
    get  'client/login',  action: 'new',     as: :client_login
    post 'client/login',  action: 'create'
    get  'client/logout', action: 'destroy', as: :client_logout
  end

  devise_for :users,
             controllers: { sessions: 'sessions' },
             path_names: {
               sign_up: 'join',
               sign_in: 'login',
               sign_out: 'logout'
             },
             path: ''

  resources :users

  if Rails.env.development?
    get '/rails/mailers' => 'rails/mailers#index'
    get '/rails/mailers/*path' => 'rails/mailers#preview'
  end

  scope module: 'client_project' do
    get ':id', action: 'root', as: :client_project_root
    get ':id/menu', action: 'menu', as: :client_project_menu
    get ':id/agency_logo', action: 'agency_logo', as: :client_project_agency_logo
    get ':id/client_logo', action: 'client_logo', as: :client_project_client_logo

    get ':id/documents/download/:document_id', action: 'download_document', as: :client_project_download_document
    get ':id/documents/download_primary/:document_id', action: 'download_primary_document', as: :client_project_download_primary_document
    get ':id/photos/download/:gallery_photo_id', action: 'download_gallery_photo', as: :client_project_download_gallery_photo
    get ':id/:top_level/:category_id/photos/:gallery_id', action: :gallery_show, as: :client_project_gallery
    get ':id/:top_level/:category_id/photos/:gallery_id/:gallery_photo_id', action: :gallery_photo, as: :client_project_gallery_photo
    get ':id/:top_level/:category_id', action: 'category', as: :client_project_category
    get ':id/:top_level/:category_id/:document_id', action: 'document', as: :client_project_category_document
    get ':id/:category_id', action: 'category'
  end
end
