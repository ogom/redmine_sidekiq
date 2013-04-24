require 'sidekiq'
require 'sidekiq-status'

module RedmineSidekiq
  class Configure
    file = File.join(Rails.root, 'plugins/redmine_sidekiq/config/sidekiq.yml')
    config = YAML.load_file(file)[Rails.env]
    redis_conf = config['redis'].symbolize_keys
    st_expire = config['status']['expiration'].to_i

    Sidekiq.configure_server do |config|
      config.redis = redis_conf
      config.server_middleware do |chain|
        chain.add Sidekiq::Status::ServerMiddleware, expiration: st_expire.minutes
      end
    end

    Sidekiq.configure_client do |config|
      config.redis = redis_conf
      config.client_middleware do |chain|
        chain.add Sidekiq::Status::ClientMiddleware
      end
    end
  end
end
