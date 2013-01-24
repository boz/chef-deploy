require_recipe "deploy::app-base"
package  "ruby-dev"
package  "postgresql-client"
chef_gem "bundler"
require_recipe "unicorn"

node.deploy.applications.each do |app|

  next unless app[:type] == "rails"

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

    deploy_app_rails do
      user   node.deploy.username
      vhosts app[:vhosts]
      port   app[:port]
    end

    action :force_deploy
  end
end
