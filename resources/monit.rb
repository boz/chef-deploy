actions :install, :monitor, :unmonitor
default_action :install

attribute :pidfile, :kind_of => [String,NilClass]
attribute :source , :kind_of => String, :default => "monitrc.erb"