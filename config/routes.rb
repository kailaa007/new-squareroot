Rails.application.routes.draw do

  
  resources :checklist_answers do
    post 'toggle', on: :collection
    post 'restrictions', on: :collection    
  end
  resources :checklists
   devise_for :users,
    controllers: {
       registrations: :registrations, sessions: :sessions, passwords: :passwords
      },
    path_names: {
      password: 'forgot',
      registration: 'register',
      sign_up: 'signup'
    }
    
  as :user do  
    get '/login', to: 'sessions#new' 
    post 'login', to: 'sessions#new' 
    get '/sign_up', to: 'registrations#new'
    get '/edit_profile', to: "devise/registrations#edit"
    get "/forgot/new", to: "passwords#new"
  end  
  
  namespace :admin do
    resources :administrators, :news, :tags, :questions, :checklists   
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
    get 'send_email_report', on: :member  
  end  
  
  get '/get_restriction', to: 'birth_plan_answers#get_restriction'
  get "edit_questions" => "birth_plan_answers#edit"

  resources :birth_plan_answers, :path => 'questions' do
    get :report, on: :collection
    get 'save_session', on: :collection
  end  
  get "/profile", to: "users#profile", as: "profile"
  get "/set_birth_plan", to: "birth_plans#set_birth_plan", as: "set_birth_plan"  
  root to: 'public#video'

end
