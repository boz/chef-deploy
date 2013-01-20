#
# Cookbook Name:: deploy
# Recipe:: db-base
#
# Copyright (C) 2013 Adam Bozanich
# 
# All rights reserved - Do Not Redistribute
#

include_recipe "build-essential"

package "ruby-dev" do
  action :nothing
end.run_action(:install)

package "postgresql-client" do
  action :nothing
end.run_action(:install)

package "libpq-dev" do
  action :nothing
end.run_action(:install)

chef_gem "pg"
