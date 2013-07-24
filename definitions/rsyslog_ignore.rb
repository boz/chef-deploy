define(:deploy_rsyslog_ignore,:message => nil, :priority => "01") do
  unless params[:message].nil? || params[:message].empty?
    service 'rsyslog' do
      action :nothing
      supports [:start,:stop,:restart,:reload]
    end
    template "/etc/rsyslog.d/#{params[:priority]}-#{params[:name]}.conf" do
      source "rsyslog-ignore.conf.erb"
      cookbook "deploy"
      variables(:messages => Array(params[:message]))
      notifies(:restart,resources(:service => 'rsyslog'))
    end
  end
end
