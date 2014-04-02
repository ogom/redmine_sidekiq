class SandboxWorker
  include Sidekiq::Worker
  sidekiq_options retry: 2

  def perform(name=nil, count=nil)
    puts 'Doing sandbox work'
    raise 'Failed sandbox work' if name == 'failed'
  end
end
