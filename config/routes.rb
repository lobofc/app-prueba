Rails.application.routes.draw do
  resources :contracts

  resources :contests

   get '/cssslider', to: 'app/front#cssslider', as: :app_cssslider
   get '/atencion', to: 'app/front#atencion', as: :app_atencion
   get '/colocacioninstrumentos', to: 'app/front#colocacioninstrumentos', as: :app_colocacioninstrumentos
   get '/index', to: 'app/front#index', as: :app_index
   get '/estructuracion', to: 'app/front#estructuracion', as: :app_estructuracion
   get '/quienessomos', to: 'app/front#quienessomos', as: :app_quienessomos
   get '/juridica', to: 'app/front#juridica', as: :app_juridica
   get '/emisor', to: 'app/front#emisor', as: :app_emisor
   get '/ventajas', to: 'app/front#ventajas', as: :app_ventajas
   get '/contacto', to: 'app/front#contacto', as: :app_contacto
   get '/colocacion', to: 'app/front#colocacion', as: :app_colocacion
   get '/tarifas', to: 'app/front#tarifas', as: :app_tarifas
   get '/persona', to: 'app/front#persona', as: :app_persona
   get '/marcolegal', to: 'app/front#marcolegal', as: :app_marcolegal
   get '/concurso', to: 'contests#concurso'
   get '/contrataciones', to: 'contracts#contrataciones'
   get '/new', to: 'contests#new'
   get '/contrataciones', to: 'app/front#contrataciones', as: :app_contrataciones
   get '/mercadosecundario', to: 'app/front#mercadosecundario', as: :app_mercadosecundario
   get '/custodia', to: 'app/front#custodia', as: :app_custodia
   get '/estadisticas', to: 'app/front#estadisticas', as: :app_estadisticas
   get '/aplicacion', to: 'app/front#aplicacion', as: :app_aplicacion
   get '/calculadora', to: 'app/front#calculadora', as: :app_calculadora
   get '/admin/chart/un_chart/:id', to: 'admin/charts#un_chart', as: :un_chart
   get '/estadisticas/chart_front/:id', to: 'app/front#chart_front', as: :chart_front
  root to: 'app/front#index'

  devise_for :users, skip: KepplerConfiguration.skip_module_devise

  namespace :admin do
    resources :charts do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      delete(
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :banners do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      delete(
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :indicators do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      delete(
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :customizes do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      post '/install_default', action: 'install_default'
      delete(
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    root to: 'admin#root'

    resources :users do
      get '(page/:page)', action: :index, on: :collection, as: ''
      delete(
        '/destroy_multiple',
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :meta_tags do
      get '(page/:page)', action: :index, on: :collection, as: ''
      delete(
        '/destroy_multiple',
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :google_adwords do
      get '(page/:page)', action: :index, on: :collection, as: ''
      delete(
        '/destroy_multiple',
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :google_analytics_tracks do
      get '(page/:page)', action: :index, on: :collection, as: ''
      delete(
        '/destroy_multiple',
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :settings, only: [] do
      collection do
        get '/:config', to: 'settings#edit', as: ''
        put '/:config', to: 'settings#update', as: 'update'
        put '/:config/appearance_default', to: 'settings#appearance_default', as: 'appearance_default'
      end
    end
  end

  # Errors routes
  match '/403', to: 'errors#not_authorized', via: :all, as: :not_authorized
  match '/404', to: 'errors#not_found', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  # Dashboard route engine
  mount KepplerGaDashboard::Engine, at: 'admin/dashboard', as: 'dashboard'
  mount KepplerContactUs::Engine, :at => '/', as: 'messages'
end
