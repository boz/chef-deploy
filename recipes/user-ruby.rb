#
# Cookbook Name:: bootstrap
# Recipe:: user-ruby
#
# Copyright (C) 2013 Adam Bozanich
# 
# All rights reserved - Do Not Redistribute
#

require_recipe "build-essential"
require_recipe "postgresql::client"

node['rvm']['user_installs'] = [{
  'user'        => node.deploy.username,
  'global_gems' => (node.deploy.base_gems + node.deploy.gems)
}]

require_recipe "rvm::user"
