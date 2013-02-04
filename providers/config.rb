require 'json'
require 'yaml'

action :before_compile do
  new_resource.symlink_before_migrate.update({
    new_resource.file => ::File.join(new_resource.directory,new_resource.file)
  })
end

action :before_deploy do

  if new_resource.file.end_with?("yml")
    data = new_resource.variables.to_yml
  elsif new_resource.file.end_with?("json")
    data = new_resource.variables.to_json
  end

  file(::File.join(new_resource.path,'shared',new_resource.file)) do
    owner new_resource.owner
    group new_resource.group
    mode "644"
    content(data)
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
