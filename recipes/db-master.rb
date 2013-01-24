#
# Cookbook Name:: deploy
# Recipe:: db-master
#
# Copyright (C) 2013 Adam Bozanich
#
# All rights reserved - Do Not Redistribute
#

include_recipe "deploy::db-base"
include_recipe "deploy::user-base"

node.deploy.databases.each do |db_name,db|
  node.postgresql.pg_hba.push({
    :type   => 'host',
    :db     => db_name,
    :user   => db[:username],
    :addr   => "127.0.0.1/32",
    :method => 'md5',
  })
end

include_recipe "postgresql::server"
include_recipe "database"

directory ::File.dirname(node.deploy.postgresql.data_directory) do
  mode  "0755"
  owner 'postgres'
  group 'postgres'
  recursive true
end

execute "postgresql-move-data-directory" do
  user  "postgres"
  group "postgres"
  action :nothing
  command %{
    mv    "#{node.postgresql.config.data_directory}" "#{node.deploy.postgresql.data_directory}" &&
    ln -s "#{node.deploy.postgresql.data_directory}" "#{node.postgresql.config.data_directory}"
  }
  notifies :start, resources("service[postgresql]"), :immediately
end

ruby_block "postgresql-stop-for-move-data-directory" do
  not_if do
    ::File.exists?(::File.join(node.deploy.postgresql.data_directory,"PG_VERSION"))
  end
  block do
    # no-op
  end
  notifies :stop, resources("service[postgresql]"), :immediately
  notifies :run , resources("execute[postgresql-move-data-directory]"), :immediately
end

pg_conn = {
  :host     => "localhost" ,
  :username => 'postgres',
  :password => node.postgresql.password.postgres,
}

node.deploy.databases.each do |db_name,db|
  postgresql_database_user db[:username] do
    connection pg_conn
    password   db[:password]
    action     :create
  end
  postgresql_database db_name do
    connection pg_conn
    owner  db[:username]
    action :create
  end
end
