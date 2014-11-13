Rails.application.routes.draw do
  resources :campaigns

  root to: 'campaigns#index', via: :get

end
