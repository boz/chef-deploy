include Chef::Resource::ApplicationBase

attribute :port   , :kind_of => Integer, :default => 8080
attribute :hosts  , :kind_of => Array  , :default => ["localhost"]
attribute :user   , :kind_of => String , :default => "deploy"
attribute :vhosts , :kind_of => Array
