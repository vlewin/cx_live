Rails.application.routes.draw do
  resources :campaigns do
    member do
      match 'search' => 'campaigns#show', via: [:get, :post], as: :search
      get 'values' => 'campaigns#values', as: :values
      # match 'search' => 'campaigns#search', via: [:get, :post], as: :search
    end
  end

  root to: 'campaigns#index', via: :get

end
