require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BackendChalenge
  class Application < Rails::Application
    config.load_defaults 8.0

    config.autoload_lib(ignore: %w[assets tasks])

    config.i18n.default_locale = :'pt-BR'
    config.i18n.available_locales = [ :'pt-BR', :en ]
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]

    config.autoload_paths += Dir["#{config.root}/services/**/"]

    config.time_zone = ENV.fetch("TZ", "America/Fortaleza")
    config.active_record.default_timezone = :utc

    config.active_job.queue_adapter = :sidekiq

    config.api_only = true

    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore, key: "_your_app_session"
  end
end
