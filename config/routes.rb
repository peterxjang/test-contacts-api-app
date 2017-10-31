Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  get "/contacts" => "contacts#index"
  get "/contacts/:id" => "contacts#show"
  post "/contacts" => "contacts#create"
  patch "/contacts/:id" => "contacts#update"
  delete "/contacts/:id" => "contacts#destroy"

  get "/groups" => "groups#index"

  post "/users" => "users#create"
end
