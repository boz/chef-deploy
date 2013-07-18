action :install do
  my = @new_resource
  unicorn_config config_filename do
    listen({ my.port => {:tcp_nodelay => true, :backlog => 100}})
    working_directory my.directory
    worker_timeout    my.worker_timeout
    preload_app       my.preload_app
    worker_processes  my.worker_processes
    before_fork       my.before_fork
    after_fork        my.after_fork
  end

  deploy_service my.name do
    user      my.user
    directory my.directory
    syslog    my.syslog
    command   "/usr/local/bin/bundle exec unicorn"
    arguments [
      "-E" , my.environment  ,
      "-c" , config_filename ,
    ]
    environment({
      "RAILS_ENV" => my.environment,
    })
  end
end

action :restart do
  deploy_service(new_resource.name) do
    action :restart
  end
end

action :start do
  deploy_service(new_resource.name) do
    action :start
  end
end

action :stop do
  deploy_service(new_resource.name) do
    action :stop
  end
end

def config_filename
  "/etc/unicorn/#{new_resource.name}.rb"
end
