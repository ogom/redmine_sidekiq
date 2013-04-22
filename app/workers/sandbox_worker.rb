class SandboxWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options retry: 2, unique: true

  def perform(name=nil, count=nil)
    puts 'Doing sandbox work'
    raise 'Failed sandbox work' if name == 'failed'
  end
end