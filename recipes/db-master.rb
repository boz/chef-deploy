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
    :addr   => nil,
    :method => 'md5',
  })
end

include_recipe "postgresql::server"
include_recipe "database"

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
