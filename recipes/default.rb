#
# Cookbook Name:: bootstrap
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

require_recipe "build-essential"
require_recipe "postgresql::client"
require_recipe "user"

cookbook_file "/etc/vim/vimrc.local" do
  source "vimrc.local"
  mode 00644
end

cookbook_file "/etc/profile.d/editor.sh" do
  source "editor.sh"
  mode 00755
end

user_account node.deploy.username do
  ssh_keys node.deploy.ssh_keys
  action :create
end

node['rvm']['user_installs'] = [{
  'user'        => node.deploy.username,
  'global_gems' => (node.deploy.base_gems + node.deploy.gems)
}]

require_recipe "rvm::user"
