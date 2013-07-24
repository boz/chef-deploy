action :install do

  service 'rsyslog' do
    action :nothing
    supports [:start,:stop,:restart,:reload]
  end

  template "/etc/rsyslog.d/#{new_resource.priority}-#{new_resource.name}.conf" do
    source   "rsyslog-file.conf.erb"
    cookbook "deploy"
    variables({
      :name => new_resource.name,
      :path => new_resource.path
    })
    notifies(:restart,resources(:service => 'rsyslog'))
  end
end
