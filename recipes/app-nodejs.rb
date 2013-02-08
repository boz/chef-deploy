require_recipe "deploy::nodejs-base"
require_recipe "deploy::app-base"

node.deploy.applications.each do |app|
  next unless app[:type] == "nodejs"
  application app[:name] do
    path "/data/apps/#{app[:name]}"
    owner node.deploy.username
    group node.deploy.username
    repository app[:repository]
    deploy_key app[:deploy_key]
    deploy_app_nodejs do
      user   node.deploy.username
      vhosts app[:vhosts]
      port   app[:port]
    end
    deploy_config do
      file "http.json"
      variables({"port" => app[:port]})
    end
    if db_name = app[:database]
      deploy_config do
        file "#{db_name}.json"
        variables(node.deploy.databases[db_name].to_hash)
      end
    end
    action :force_deploy
  end
end
