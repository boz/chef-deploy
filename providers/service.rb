include Chef::Mixin::LanguageIncludeRecipe
action :before_compile do
  include_recipe "unicorn"
end

action :before_deploy do
end

action :before_migrate do
end

action :before_symlink do
end

action :before_restart do
  new_resource = @new_resource
  directory    = ::File.join(new_resource.path, 'current')
  config       = "/etc/unicorn/#{new_resource.name}.rb"

  unicorn_config config do
    listen({ new_resource.port => {:tcp_nodelay => true, :backlog => 100}})
    working_directory directory
    worker_timeout new_resource.worker_timeout
    preload_app new_resource.preload_app
    worker_processes new_resource.worker_processes
    before_fork new_resource.before_fork
  end

  service new_resource.name do
    provider Chef::Provider::Service::Upstart
    supports :restart => true, :start => true, :stop => true
  end

  template "#{new_resource.name}.upstart.conf" do
    path "/etc/init/#{new_resource.name}.conf"
    source "unicorn.upstart.conf.erb"
    owner "root"
    group "root"
    mode  "0644"
    variables({
      :user        => new_resource.owner,
      :directory   => directory,
      :environment => new_resource.environment_name,
      :config      => config,
    })
    notifies :restart, resources(:service => new_resource.name)
  end

  service new_resource.name do
    action [:enable,:start]
  end
end

action :after_restart do
end
