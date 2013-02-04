include Chef::Resource::ApplicationBase

attribute :file     , :kind_of => String
attribute :variables, :kind_of => Hash
attribute :directory, :kind_of => String, :default => "config"
