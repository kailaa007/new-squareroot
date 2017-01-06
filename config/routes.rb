Rails.application.routes.draw do

   devise_for :users,
    controllers: {
       registrations: :registrations,
      },
    path_names: {
      password: 'forgot',
      registration: 'register',
      sign_up: 'signup'
    }
    
  as :user do  
    get '/login', to: 'devise/sessions#new' 
    post 'login', to: 'devise/sessions#new' 
    get '/sign_up', to: 'registrations#new'
    get '/edit_profile', to: "devise/registrations#edit"
    get "/forgot/new", to: "devise/passwords#new"
  end  
  
  namespace :admin do
    resources :administrators, :news, :tags, :questions
    resources :birth_plans do
      get "assign_ques", on: :collection
      post "assign_ques", on: :collection
      patch "assign_ques", on: :collection
      post :sort, on: :collection
      get :get_question, on: :member
      post :get_question, on: :member
      get "restrict", on: :collection
      post "reset", on: :collection
      post "restrict", on: :collection
    end  

    resources :users do 
      get 'birth_plan_report', on: :member
      post 'birth_plan_report', on: :member
    end

    resources :password_resets
    resources :sessions, only: [ :new, :create, :destroy]
    resources :team_members do
      post :sort, on: :collection
    end

    get '/login'  => 'sessions#new'
    get '/logout' => 'sessions#destroy'
    #post '/admin/birth_plans/reset' => 'birth_plans#reset'

    root to: 'news#index'
  end

  %w( facts what framework solutions culture policy video team projects ).each do |page|
    get "/#{page}" => "public##{page}", as: page.to_sym
  end

  resources :news, only: [ :show, :index ]
  resources :tags, only: :show
  resources :birth_plans do
    get 'index', to: 'birth_plans#index'
    get 'active_plan', on: :collection
    post 'answer', on: :member
  end  
  
  get '/get_restriction', to: 'birth_plan_answers#get_restriction'
  get "edit_questions" => "birth_plan_answers#edit"

  resources :birth_plan_answers, :path => 'questions' do
    get :report, on: :collection
  end  
  
  root to: 'public#video'

end
