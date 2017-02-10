# frozen_string_literal: true
worker_processes 1

working_directory '/usr/local/app/Kiritori/current'

listen '/tmp/unicorn.sock'
pid File.expand_path('tmp/pids/unicorn.pid')
stderr_path File.expand_path('log/stderr.log')
stdout_path File.expand_path('log/stdout.log')

preload_app true
GC.respond_to?(:copy_on_write_friendly=) && GC.copy_on_write_friendly = true

before_exec do |_|
  ENV['BUNDLE_GEMFILE'] = File.expand_path('Gemfile')
end

before_fork do |server, _|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exist?(old_pid) && old_pid != server.pid
    Process.kill :QUIT, File.read(old_pid).to_i
  end
end

after_fork do |_, _|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end
