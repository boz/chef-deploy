name             "deploy"
maintainer       "Adam Bozanich"
maintainer_email "adam.boz@gmail.com"
license          "All rights reserved"
description      "Installs/Configures deploy user"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

recipe "deploy::user-base", "Install deploy user"
recipe "deploy::user-ruby", "Install ruby and rvm"
recipe "deploy::user-bootstrap", "Prepare a clean AMI"
recipe "deploy::db-base", "Database libraries"
recipe "deploy::db-master", "Install and configure master database"

depends "build-essential", "~> 1.3.2"
depends "postgresql", "~> 2.1.0"
depends "rvm", "~> 0.9.1"
depends "user", "~> 0.3.1"
depends "database", "~> 1.3.10"
