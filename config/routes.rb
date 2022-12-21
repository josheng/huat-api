Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/4d/result', to: 'results#fourdlatestresult'
      get '/4d/dates', to: 'results#fourdgetdate'
      post '/4d/results', to: 'results#fourddatedresult'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
