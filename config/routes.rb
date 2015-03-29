Rails.application.routes.draw do
  require_relative '../lib/constraints/grant_type'

  resources :users
  resources :current_users, only: [:show]
  get '/status' => 'oauth#status'

  post 'oauth/token' => 'oauth#create', as: :create_token,
    constraints: Constraint::GrantType.new('password')
  post 'oauth/token' => 'oauth#refresh', as: :refresh_token,
    constraints: Constraint::GrantType.new('refresh_token')
end
