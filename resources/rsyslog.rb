actions :install
default_action :install
attribute :path    , :kind_of => String          , :required => true
attribute :priority, :kind_of => [Integer,String], :default => "60"
