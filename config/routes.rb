Rails.application.routes.draw do
  root 'home#index' 

  resources :student_profiles
        
  
  devise_for :students, :controllers => { :omniauth_callbacks => "students/omniauth_callbacks" }
  # devise_for :students, controllers: {sessions: "students/sessions", registrations: "students/registrations", passwords: "students/passwords", confirmations: "students/confirmations", unlocks: "students/unlocks"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end

