if node[:platform_version].to_f >= 12.10
  package "software-properties-common"
end

execute "ppa-apt-get-update" do
  command "apt-get -y update"
  action :nothing
end
