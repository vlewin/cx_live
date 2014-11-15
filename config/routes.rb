Rails.application.routes.draw do
  resources :campaigns do
    member do
      match 'search' => 'campaigns#show', via: [:get, :post], as: :search
      get 'filter_values' => 'campaigns#filter_values', as: :filter_values
      get 'add_filter' => 'campaigns#add_filter', as: :add_filter
    end
  end

  root to: 'campaigns#index', via: :get

end
