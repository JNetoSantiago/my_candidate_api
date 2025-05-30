Rails.application.routes.draw do
  require "sidekiq/web"

  mount Sidekiq::Web => "/sidekiq"

  Sidekiq::Web.use(Rack::Auth::Basic) do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(Rails.application.credentials[Rails.env.to_sym][:sidekiqweb][:username])) &&
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(Rails.application.credentials[Rails.env.to_sym][:sidekiqweb][:password]))
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
