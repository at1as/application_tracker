Rails.application.routes.draw do
  
  get 'contacts/new'

  # Main Page
  root 'sessions#new'

  # Nested Controllers
  resources :users, except: [:index] do
    resources :companies do
      resources :contacts
      resources :positions
    end
  end
  
  # Custom URLs 
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get    'signup'  => 'users#new'  

  get 'users/:user_id/companies/:id/remove_attachment', to: 'companies#remove_attachment', as: 'remove_company_attachment'
  
end
