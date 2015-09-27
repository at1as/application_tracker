Rails.application.routes.draw do
  
  get 'contacts/new'

  # Main Page
  root 'sessions#new'

  # Nested Controllers
  resources :users do
    resources :companies do
      resources :contacts
    end #, only: [:create, :update, :destroy]
  end
  
  # Custom URLs 
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get    'signup'  => 'users#new'  

end
