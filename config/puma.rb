max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

if ENV["RAILS_ENV"] == "production"
  require "concurrent-ruby"
  worker_count = Integer(ENV.fetch("WEB_CONCURRENCY") { Concurrent.physical_processor_count })
  workers worker_count if worker_count > 1
end

worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

app_dir = ENV.fetch("PWD") { File.expand_path("../..", __FILE__) }
socket_dir = "#{app_dir}/tmp/sockets"
socket_path = "#{socket_dir}/puma.sock"

require 'fileutils'
FileUtils.mkdir_p(socket_dir)

bind "unix://#{socket_path}"

FileUtils.chmod(0777, socket_dir) if File.directory?(socket_dir)

environment ENV.fetch("RAILS_ENV") { "development" }

pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

plugin :tmp_restart

on_worker_boot do
  FileUtils.chmod(0777, socket_path) if File.exist?(socket_path)
end

after_worker_boot do
  FileUtils.chmod(0777, socket_path) if File.exist?(socket_path)
end