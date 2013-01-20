include Chef::Resource::ApplicationBase

attribute :application_port, :kind_of => Integer
attribute :port            , :kind_of => Integer, :default => 80
attribute :hosts           , :kind_of => Array  , :default => ["localhost"]
attribute :vhosts          , :kind_of => Array

