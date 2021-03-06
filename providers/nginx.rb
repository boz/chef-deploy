action :install do
  service 'nginx' do
    supports :status => true, :restart => true, :reload => true
    action :nothing
  end
  group "ssl-cert" do
    action :modify
    append true
    members "www-data"
  end
  template "#{node['nginx']['dir']}/sites-available/#{new_resource.name}.conf" do
    source   "nginx.conf.erb"
    cookbook new_resource.cookbook
    owner "root"
    group "root"
    mode  "644"
    variables({
      :name             => new_resource.name             ,
      :vhosts           => new_resource.vhosts           ,
      :hosts            => new_resource.hosts            ,
      :directory        => new_resource.directory        ,
      :port             => new_resource.port             ,
      :sslport          => new_resource.sslport          ,
      :application_port => new_resource.application_port ,
    })
    notifies :reload, resources(:service => 'nginx')
  end
end

action :enable do
  service 'nginx' do
    supports :status => true, :restart => true, :reload => true
    action :nothing
  end
  nginx_site "#{new_resource.name}.conf"
end

action :disable do
  service 'nginx' do
    supports :status => true, :restart => true, :reload => true
    action :nothing
  end
  nginx_site "#{new_resource.name}.conf" do
    action :disable
  end
end
