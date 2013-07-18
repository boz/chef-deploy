service 'rsyslog' do
  action :nothing
  supports [:start,:stop,:restart,:reload]
end

if node.rsyslog.ssl
  cookbook_file node.rsyslog.crt do
    source "syslog.crt"
    mode 00644
  end
end

template "/etc/rsyslog.conf" do
  source "rsyslog.conf.erb"
  variables(:options => node.rsyslog)
  notifies(:restart,resources(:service => 'rsyslog'))
end
