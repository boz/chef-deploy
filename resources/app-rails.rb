include Chef::Resource::ApplicationBase

attribute :port   , :kind_of => Integer, :default => 8080
attribute :hosts  , :kind_of => Array  , :default => ["localhost"]
attribute :user   , :kind_of => String , :default => "deploy"
attribute :vhosts , :kind_of => Array
attribute :preload, :kind_of => [TrueClass,FalseClass,NilClass], :default => false
attribute :syslog , :kind_of => [TrueClass,FalseClass,NilClass], :default => false
attribute :num_workers, :kind_of => Integer, :default => [node['cpu']['total'].to_i * 4, 8].min
