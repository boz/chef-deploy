require_recipe "deploy-user"
require_recipe "git"

node.nginx.package_name   = "nginx-full"
node.nginx.install_method = "package"
include_recipe 'nginx'

require_recipe 'deploy::monit'
