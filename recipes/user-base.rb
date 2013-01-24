#
# Cookbook Name:: deploy
# Recipe:: user-base
#
# Copyright (C) 2013 Adam Bozanich
# 
# All rights reserved - Do Not Redistribute
#

require_recipe "user"

user_account node.deploy.username do
  ssh_keys node.deploy.ssh_keys
  action :create
end

cookbook_file "/etc/vim/vimrc.local" do
  source "vimrc.local"
  mode 00644
end

cookbook_file "/etc/profile.d/editor.sh" do
  source "editor.sh"
  mode 00755
end

cookbook_file "/etc/gemrc" do
  source "gemrc"
  mode 00644
end
