require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.require_master_key = true
  config.public_file_server.enabled = false
  config.assets.compile = false
  config.action_dispatch.x_sendfile_header = "X-Accel-Redirect"
  config.active_storage.service = :local
  config.active_storage.resolve_model_to_route = :rails_storage_proxy
  
  config.action_controller.default_url_options = { host: 'cinemad.emadrahimi.dev', protocol: 'https' }
  config.action_mailer.default_url_options = { host: 'cinemad.emadrahimi.dev', protocol: 'https' }
  Rails.application.routes.default_url_options = { host: 'cinemad.emadrahimi.dev', protocol: 'https' }
  
  config.force_ssl = true
  
  config.logger = ActiveSupport::Logger.new("#{Rails.root}/log/production.log", 5, 50.megabytes)
    .tap  { |logger| logger.formatter = ::Logger::Formatter.new }
    .then { |logger| ActiveSupport::TaggedLogging.new(logger) }
  
  config.log_tags = [ :request_id ]
  config.log_level = :info
  
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.active_record.dump_schema_after_migration = false
  
  config.hosts = [
    "cinemad.emadrahimi.dev",
    "www.cinemad.emadrahimi.dev"
  ]
  
  config.host_authorization = { exclude: ->(request) { request.path == "/up" } }
  
  config.public_file_server.headers = {
    'Cache-Control' => 'public, max-age=31536000'
  }
  
  config.action_controller.asset_host = ENV['ASSET_HOST'] if ENV['ASSET_HOST']
end