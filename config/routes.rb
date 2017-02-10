Rails.application.routes.draw do
  root 'homes#index'
  resource :home, only: %i(index create)
end
