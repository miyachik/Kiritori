Rails.application.routes.draw do
  root 'ab_tests#index'
  resource :home, only: %i(index create)
  resource :ab_tests, only: %i(index new create edit update destroy) do
    member do
      get :rebuild
    end
  end
end
