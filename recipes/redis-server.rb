include_recipe "deploy::user-base"

package "redis-server" do
  action :install
end

service "redis-server" do
  action [:stop,:disable]
end

service "redis" do
  provider Chef::Provider::Service::Upstart
  supports :restart => true, :start => true, :stop => true
end

directory node[:redis][:datadir] do
  owner node[:redis][:user]
  group node[:redis][:group]
  recursive true
end

template "redis.conf" do
  path "#{node[:redis][:confdir]}/redis.conf"
  source "redis.conf.erb"
  owner "root"
  group "root"
  mode  "0644"
  variables :redis => node[:redis]
  notifies :restart, resources(:service => "redis")
end

template "redis.upstart.conf" do
  path   "/etc/init/redis.conf"
  source "redis.upstart.conf.erb"
  owner  "root"
  group  "root"
  mode   "0644"
  variables :redis => node[:redis]
  notifies :restart, resources(:service => "redis")
end
