module RedmineSidekiq
  class Rails
    Dir.glob(File.join(Redmine::Plugin.directory, '*')).sort.each do |directory|
      if File.directory?(directory)
        workers = File.join(directory, 'app', 'workers')
        if File.directory?(workers)
          ActiveSupport::Dependencies.autoload_paths += [workers]
        end
      end
    end
  end
end
