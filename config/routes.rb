require "sidekiq/web"

Sidekiq::Web.use(Rack::Auth::Basic) do |username, password|
  ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(Rails.application.credentials[Rails.env.to_sym][:sidekiqweb][:username])) &&
  ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(Rails.application.credentials[Rails.env.to_sym][:sidekiqweb][:password]))
end

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      post "csv_upload", to: "csv_upload#handler"

      get "politicians", to: "politicians/list#handler"
      get "politicians/:id", to: "politicians/show#handler"
    end
  end
end
