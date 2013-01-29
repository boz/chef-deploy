package "monit"

service "monit" do
  action   [:enable,:start]
  supports [:reload,:start,:stop]
end

template "/etc/monit/monitrc" do
  source "monitrc.erb"
  owner "root"
  group "root"
  mode  "0600"
  variables(:monit => node[:monit])
  notifies :reload, resources(:service => :monit)
end

template "/etc/monit/conf.d/system.conf" do
  source "system.monitrc.erb"
  owner "root"
  group "root"
  mode  "0600"
  variables(:fqdn => node[:fqdn])
  notifies :reload, resources(:service => :monit), :immediately
end

node.filesystem.each do |_device,attrs|

  next unless _device.start_with?("/")
  next unless attrs[:mount]
  next unless attrs[:mount].start_with?("/")
  next unless attrs[:mount_options]
  next unless attrs[:mount_options].include?(node.monit.fs.mountopts)
  next unless node.monit.fs.fstypes.include?(attrs[:fs_type])

  deploy_monitrc_fs ::File.basename(_device) do
    path attrs[:mount]
  end
end
