
node.nginx.package_name   = "nginx-full"
node.nginx.install_method = "package"

require_recipe "git"
require_recipe "deploy::db-base"
chef_gem "bundler"

node.deploy.applications.each do |app|

  application app[:name] do
    path "/data/apps/#{app[:name]}"
    owner node.deploy.username
    group node.deploy.username
    repository app[:repository]
    deploy_key app[:deploy_key]
    migrate true

    db = node.deploy.databases[app[:database]]

    rails do
      gems [["bundler","~> 1.2.1"]]
      bundler true
      precompile_assets true
      database do
        adapter  'postgresql'
        host     db[:host]
        database app[:database]
        username db[:username]
        password db[:password]
      end
    end

    deploy_service do
      port app[:port]
    end

    deploy_nginx do
      vhosts app[:vhosts]
      application_port app[:port]
    end
  end
end
