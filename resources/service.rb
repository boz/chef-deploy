actions :enable, :start, :stop, :restart
default_action :enable

attribute :name        , :kind_of => String
attribute :user        , :kind_of => String
attribute :directory   , :kind_of => String, :default => "/"
attribute :command     , :kind_of => String
attribute :arguments   , :kind_of => Array, :default => []
attribute :environment , :kind_of => Hash , :default => {}

