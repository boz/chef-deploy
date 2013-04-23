action :enable do
  template "/etc/init/#{new_resource.name}.conf" do
    cookbook new_resource.cookbook
    source "upstart.conf.erb"
    owner "root"
    group "root"
    mode  "0644"
    variables({
      :user        => new_resource.user        ,
      :directory   => new_resource.directory   ,
      :name        => new_resource.name        ,
      :command     => new_resource.command     ,
      :arguments   => new_resource.arguments   ,
      :environment => new_resource.environment ,
    })
    notifies :restart, resources(:deploy_service => new_resource.name)
  end
end

action :restart do
  execute "/sbin/initctl stop #{new_resource.name}; /sbin/initctl start #{new_resource.name}"
end

action :start do
  execute "/sbin/initctl start #{new_resource.name}"
end

action :stop do
  execute "/sbin/initctl stop #{new_resource.name}"
end
