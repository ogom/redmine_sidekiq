require 'redmine_sidekiq/configure'
require 'redmine_sidekiq/rails'

Redmine::Plugin.register :redmine_sidekiq do
  name 'Redmine Sidekiq plugin'
  description 'This is a Sidekiq plugin for Redmine'
  version '2.0.0'
  url 'https://github.com/ogom/redmine_sidekiq'
  author_url 'mailto:ogom@hotmail.co.jp'
  author 'ogom'

  menu :top_menu, :sidekiq, '/sidekiq', :if => Proc.new {User.current.admin}
end
