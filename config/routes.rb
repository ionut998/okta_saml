Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'helloworld#index'
  get 'accounts', to: 'helloworld#accounts'
  delete 'logout', to: 'helloworld#logout'

  get 'saml/init'
  post 'saml/consume'
end
