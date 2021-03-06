Rails.application.routes.draw do
  
  get 'contacts/new'

  # Main Page
  root 'sessions#new'
  
  # High precedence custom routes
  get 'users/:user_id/companies/filter', to: 'companies#filter', as: 'filter_companies'
  get 'users/:user_id/companies/csv', to: 'companies#to_csv', as: 'companies_csv'
  get 'users/:user_id/companies/calendar', to: 'companies#calendar', as: 'calendar'
  get 'users/:user_id/change_email', to: 'users#change_email', as: 'change_email'
  post 'users/:user_id/change_email', to: 'users#update_email', as: 'update_email'
  get 'users/:user_id/timezone', to: 'users#change_timezone', as: 'change_timezone'
  post 'users/:user_id/timezone', to: 'users#update_timezone', as: 'update_timezone'

  # Nested Controllers
  resources :users, except: [:index] do
    resources :companies do
      resources :contacts
      resources :events
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
