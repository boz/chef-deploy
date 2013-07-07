actions :install, :monitor, :unmonitor
default_action :install
attribute :pidfile , :kind_of => [String,NilClass]
attribute :source  , :kind_of => String, :default => "monitrc.erb"
attribute :cookbook, :kind_of => String, :default => "deploy"
attribute :tests   , :kind_of => Array , :default => []
