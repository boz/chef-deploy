actions :create
default_action :create

attribute :device   , :kind_of => String, :name_attribute => true
attribute :path     , :kind_of => String
attribute :spacemax , :kind_of => String, :default => '90%'
attribute :inodemax , :kind_of => String, :default => '90%'

