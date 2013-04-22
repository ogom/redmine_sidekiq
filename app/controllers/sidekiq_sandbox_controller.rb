class SidekiqSandboxController < ApplicationController
  unloadable
  before_filter :require_admin

  def index
    @stats = Sidekiq::Stats.new
  end

  def perform_async
    name = params['name']
    count = params['count']
    jid = SandboxWorker.perform_async(name, count)
    flash[:notice] = "Enqueued job id: #{jid}" if jid
    redirect_to :action => 'index'
  end

  def perform_in
    interval = params['interval'].to_i ||= 2
    jid = SandboxWorker.perform_in(interval.minute)
    flash[:notice] = "Enqueued job id: #{jid}" if jid
    redirect_to :action => 'index'
  end

  def perform_at
    interval = params['interval'].to_i ||= 2
    jid = SandboxWorker.perform_at(interval.minute.from_now)
    flash[:notice] = "Enqueued job id: #{jid}" if jid
    redirect_to :action => 'index'
  end
end
