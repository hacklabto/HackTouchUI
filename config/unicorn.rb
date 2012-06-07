env = ENV['RAILS_ENV'] || "development"


worker_processes (env == "development" ? 8 : 16)
preload_app true
timeout 30
#stderr_path "log/unicorn_#{env}.log"

#if env != "development"
#  pid "tmp/pids/unicorn.pid"
#end

#if env == "development"
  listen 8082
#else
#  listen "/tmp/.sock", :backlog => 2048
#  listen 8080, :tcp_nopush => true
#end

before_fork do |server, worker|
  ##
  # When sent a USR2, Unicorn will suffix its pidfile with .oldbin and
  # immediately start loading up a new version of itself (loaded with a new
  # version of our app). When this new Unicorn is completely loaded
  # it will begin spawning workers. The first worker spawned will check to
  # see if an .oldbin pidfile exists. If so, this means we've just booted up
  # a new Unicorn and need to tell the old one that it can now die. To do so
  # we send it a QUIT.
  #
  # Using this method we get 0 downtime deploys.
  old_pid = File.join Padrino.root, 'tmp/pids/unicorn.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  #ActiveRecord::Base.establish_connection
end
