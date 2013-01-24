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
  deploy_unicorn new_resource.application.name do
    user        new_resource.user
    port        new_resource.port
    directory   ::File::join(new_resource.path,'current')
    environment new_resource.environment_name
  end
end
action :after_restart do
  deploy_nginx new_resource.application.name do
    action :enable
  end
end
