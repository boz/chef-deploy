include Chef::Mixin::LanguageIncludeRecipe

action :before_compile do
  include_recipe 'nginx'
end

action :before_deploy do
  template "#{node['nginx']['dir']}/sites-available/#{new_resource.application.name}.conf" do
    source   "nginx.conf.erb"
    cookbook "deploy"
    owner "root"
    group "root"
    mode "644"
    variables :resource => new_resource, :vhosts => new_resource.vhosts
    notifies :reload, resources(:service => 'nginx')
  end
  nginx_site "#{new_resource.application.name}.conf"
  nginx_site "default" do
    enable false
  end
end
action :before_migrate do
end
action :before_symlink do
end
action :before_restart do
end
action :after_restart do
end
