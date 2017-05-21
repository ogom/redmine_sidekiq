require 'sidekiq'

# Enable extensions if sidekiq version > 4
if Sidekiq::Extensions.respond_to?(:enable_delay!)
  Sidekiq::Extensions.enable_delay!
end

module RedmineSidekiq
  class Configure
    file = File.join(Rails.root, 'plugins/redmine_sidekiq/config/sidekiq.yml')
    if File.exist?(file)
      config = YAML.load_file(file)[Rails.env]
      redis_conf = config['redis'].symbolize_keys
    end

    Sidekiq.configure_server do |config|
      config.redis = redis_conf if redis_conf
    end

    Sidekiq.configure_client do |config|
      config.redis = redis_conf if redis_conf
    end

    Sidekiq::Extensions::ActiveRecord.module_eval do
      remove_method :delay if respond_to?(:delay)
    end

    Sidekiq::Extensions::ActionMailer.module_eval do
      remove_method :delay if respond_to?(:delay)
    end

    Sidekiq::Extensions::Klass.module_eval do
      remove_method :delay if respond_to?(:delay)
    end

    Sidekiq.remove_delay! if Sidekiq.methods.index(:remove_delay!)

  end
end
