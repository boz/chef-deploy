action :before_compile do
  new_resource.restart_command do
    deploy_unicorn new_resource.application.name do
      action :restart
    end
  end
end
action :before_deploy do
  deploy_nginx new_resource.application.name do
    application_port new_resource.port
    hosts            new_resource.hosts
    vhosts           new_resource.vhosts
    directory        ::File.join(new_resource.application.path,"current","public")
  end
end
action :before_migrate do
end
action :before_symlink do
end
action :before_restart do
  deploy_monit new_resource.application.name do
    action :unmonitor
    ignore_failure true
  end
  deploy_unicorn new_resource.application.name do
    user        new_resource.user
    port        new_resource.port
    preload_app new_resource.preload
    directory   ::File::join(new_resource.path,'current')
    environment new_resource.environment_name
    worker_processes new_resource.num_workers
    syslog new_resource.syslog
  end
  deploy_rsyslog new_resource.application.name do
    path ::File.join(new_resource.application.path,"current","log","#{new_resource.environment_name}.log")
  end if new_resource.syslog
end
action :after_restart do
  deploy_nginx new_resource.application.name do
    action :enable
  end
  deploy_monit new_resource.application.name do
    source  "unicorn.monitrc.erb"
    tests [
      %{if cpu usage > 95% for 3 cycles then restart},
      %{if totalmem > #{256 * new_resource.num_workers} Mb then alert  },
      %{if totalmem > #{384 * new_resource.num_workers} Mb then restart}
    ]
    action [:install,:monitor]
  end
end
