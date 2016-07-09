Rails.application.routes.draw do
  root 'home#index'
  resource :home, only: %i(index)

end
