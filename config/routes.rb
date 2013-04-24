require 'sidekiq/web'
require 'redmine_sidekiq/admin_constraint'

RedmineApp::Application.routes.draw do
  mount Sidekiq::Web => '/sidekiq', :constraints => RedmineSidekiq::AdminConstraint.new

  match '/sidekiq/sandbox', to: 'sidekiq_sandbox#index', via: :get
  match '/sidekiq/sandbox/perform_async', to: 'sidekiq_sandbox#perform_async', via: :post
  match '/sidekiq/sandbox/perform_in', to: 'sidekiq_sandbox#perform_in', via: :post
  match '/sidekiq/sandbox/perform_at', to: 'sidekiq_sandbox#perform_at', via: :post
end
