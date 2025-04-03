max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# Specifies the `worker_timeout` threshold that Puma will use to wait before
# terminating a worker in development environments.
worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

app_dir = File.expand_path("../..", __FILE__)

if ENV.fetch("RAILS_ENV", "development") == "production"
  # In production, use Unix socket
  require "concurrent-ruby"
  worker_count = Integer(ENV.fetch("WEB_CONCURRENCY") { Concurrent.physical_processor_count })
  workers worker_count if worker_count > 1
  
  socket_dir = "#{app_dir}/tmp/sockets"
  socket_path = "#{socket_dir}/puma.sock"
  
  require 'fileutils'
  FileUtils.mkdir_p(socket_dir)
  
  bind "unix://#{socket_path}"
  
  on_worker_boot do
    FileUtils.chmod(0777, socket_path) if File.exist?(socket_path)
  end
  
  after_worker_boot do
    FileUtils.chmod(0777, socket_path) if File.exist?(socket_path)
  end
else
  # In development, use TCP port
  port ENV.fetch("PORT") { 3000 }
end

# Specifies the `environment` that Puma will run in.
environment ENV.fetch("RAILS_ENV") { "development" }

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart