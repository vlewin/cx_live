Rails.application.routes.draw do
  resources :campaigns do
    member do
      match 'search' => 'campaigns#show', via: [:get, :post], as: :search
      # match 'search' => 'campaigns#search', via: [:get, :post], as: :search
    end
  end

  root to: 'campaigns#index', via: :get

end
