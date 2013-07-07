action :install do
  service "monit" do
    action   :nothing
    supports [:reload,:start,:stop]
  end

  _pidfile = new_resource.pidfile || "/var/run/#{new_resource.name}.pid"
  template "/etc/monit/conf.d/#{new_resource.name}.conf" do
    source   new_resource.source
    cookbook new_resource.cookbook
    owner "root"
    group "root"
    mode  "0600"
    variables({
      :name    => new_resource.name  ,
      :pidfile => _pidfile           ,
      :tests   => new_resource.tests ,
    })
    notifies :reload, resources(:service => :monit), :immediately
  end
end

action :monitor do
  execute "monit monitor #{new_resource.name}" do
    retries 5
  end
end

action :unmonitor do
  execute "monit unmonitor #{new_resource.name}" do
    ignore_failure new_resource.ignore_failure
  end
end
