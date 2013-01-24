action :install do
  Chef::Log.warn("prevent an unnecessary apt-get update by adding")
  Chef::Log.warn("    apt-add-repository -y ppa:#{new_resource.name}")
  Chef::Log.warn("to the bootstrap")
  execute "add ppa #{new_resource.name}" do
    command  "apt-add-repository -y ppa:#{new_resource.name}"
    notifies :run, resources(:execute => "ppa-apt-get-update"), :immediately
    not_if do
      source_list_exists?(new_resource.name)
    end
  end
end

def source_list_exists?(name)
  !!::File.size?(sources_list_name(name))
end

def sources_list_name(name)
  name = name.gsub('/','-')
  name = name.gsub('.','_')
  name = "#{name}-#{node[:lsb][:codename]}.list"
  "/etc/apt/sources.list.d/#{name}"
end
