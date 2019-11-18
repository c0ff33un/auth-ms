Rails.application.routes.draw do
  devise_for :users, 
              defaults: { format: :json }, 
              path: '',
              path_names: { 
                sign_in: 'login', 
                sign_out: 'logout', 
                registration: 'signup'
              },
              controllers: { sessions: 'users/sessions'}
  
  resource :user, only:[:show, :update]

  post '/guests', to: 'guests#create'
  delete '/guests', to: 'guests#destroy'

end
