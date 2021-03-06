name             "deploy"
maintainer       "Adam Bozanich"
maintainer_email "adam.boz@gmail.com"
license          "All rights reserved"
description      "Installs/Configures deploy user"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

recipe "deploy::db-base", "Database libraries"
recipe "deploy::db-master", "Install and configure master database"
recipe "deploy::app-rails-base", "Rails application base includes"
recipe "deploy::app-rails", "Deploy rails application"
recipe "deploy::redis-server", "Install and configure redis-server"
recipe "deploy::nodejs-base" , "Install nodejs"

depends "deploy-user","~> 0.1.0"

depends "apt", "~> 1.10.0"
depends "postgresql", "~> 2.1.0"
depends "database", "~> 1.3.10"
depends "nginx", "~> 1.1.5"
depends "application", "~> 2.0.1"
depends "application_ruby", "~> 1.0.8"
depends "git", "~> 2.1.2"
