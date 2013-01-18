name             "bootstrap"
maintainer       "Adam Bozanich"
maintainer_email "adam.boz@gmail.com"
license          "All rights reserved"
description      "Installs/Configures deploy user"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

recipe "bootstrap::default", "Install deploy user"

depends "build-essential", "~> 1.3.2"
depends "postgresql", "~> 2.1.0"
depends "rvm", "~> 0.9.1"
depends "user", "~> 0.3.1"

