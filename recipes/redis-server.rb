include_recipe "deploy-user"
require_recipe 'deploy::monit'

package "redis-server" do
  action :install
end

service "redis-server" do
  action [:stop,:disable]
end

directory node[:redis][:datadir] do
  owner node[:redis][:user]
  group node[:redis][:group]
  recursive true
end

config_file = ::File.join("#{node[:redis][:confdir]}","redis.conf")

deploy_service "redis" do
  user      node[:redis][:user]
  command   "/usr/bin/redis-server"
  arguments [config_file]
end

template config_file do
  source "redis.conf.erb"
  cookbook "deploy"
  owner "root"
  group "root"
  mode  "0644"
  variables :redis => node[:redis]
  notifies :restart, resources(:deploy_service => "redis")
end

deploy_monit "redis" do
  source "redis.monitrc.erb"
end

