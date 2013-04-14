require_recipe "deploy-user"
require_recipe "git"

node.nginx.package_name   = "nginx-full"
node.nginx.install_method = "package"
include_recipe 'nginx'

group "ssl-cert" do
  action :modify
  append true
  members "www-data"
end

require_recipe 'deploy::ssl-cert'
require_recipe 'deploy::monit'
