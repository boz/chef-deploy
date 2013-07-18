action :before_compile do
  new_resource.restart_command do
    deploy_service new_resource.application.name do
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
  execute "npm install" do
    cwd  new_resource.release_path
    user new_resource.owner
    environment new_resource.environment.merge({
      "USER" => new_resource.owner           ,
      "HOME" => "/home/#{new_resource.owner}",
    })
  end
end
action :before_symlink do
end
action :before_restart do
  deploy_monit new_resource.application.name do
    action :unmonitor
    ignore_failure true
  end
  deploy_service new_resource.application.name do
    user new_resource.user
    directory  ::File.join(new_resource.application.path,"current")
    command    "/usr/bin/npm"
    arguments  ["start"]
    environment({
      "PORT" => new_resource.port
    })
    syslog new_resource.syslog
  end
end
action :after_restart do
  deploy_nginx new_resource.application.name do
    action :enable
  end
  deploy_monit new_resource.application.name do
    source  "nodejs.monitrc.erb"
    action [:install,:monitor]
  end
end
