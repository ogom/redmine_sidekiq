require 'sidekiq'
require 'sidekiq-status'

module RedmineSidekiq
  class Configure
    file = File.join(Rails.root, 'plugins/redmine_sidekiq/config/sidekiq.yml')
    if File.exist?(file)
      config = YAML.load_file(file)[Rails.env]
      redis_conf = config['redis'].symbolize_keys
      st_expire = config['status']['expiration'].to_i
    else
      st_expire = 30
    end

    Sidekiq.configure_server do |config|
      config.redis = redis_conf if redis_conf
      config.server_middleware do |chain|
        chain.add Sidekiq::Status::ServerMiddleware, expiration: st_expire.minutes
      end
    end

    Sidekiq.configure_client do |config|
      config.redis = redis_conf if redis_conf
      config.client_middleware do |chain|
        chain.add Sidekiq::Status::ClientMiddleware
      end
    end

    Sidekiq::Extensions::ActiveRecord.module_eval do
      remove_method :delay if respond_to?(:delay)
    end

    Sidekiq::Extensions::ActionMailer.module_eval do
      remove_method :delay if respond_to?(:delay)
    end
  end
end
