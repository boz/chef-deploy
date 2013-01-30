action :create do
  service "monit" do
    action   :nothing
    supports [:reload,:start,:stop]
  end
  template "/etc/monit/conf.d/#{new_resource.device}.fs.conf" do
    source "fs.monitrc.erb"
    owner "root"
    group "root"
    mode  "0600"
    variables({
      :device   => new_resource.device   ,
      :path     => new_resource.path     ,
      :spacemax => new_resource.spacemax ,
      :inodemax => new_resource.inodemax ,
    })
    notifies :reload, resources(:service => :monit)
  end
end
