require_recipe "deploy::app-base"
package  "ruby-dev"
package  "postgresql-client"
chef_gem "bundler"
require_recipe "unicorn"