Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.berkshelf.enabled = true
  # The path to the Berksfile to use with Vagrant Berkshelf
  # config.berkshelf.berksfile_path = "./Berksfile"

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.only = []

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.except = []

  config.vm.hostname = "bootstrap-berkshelf"

  config.vm.box     = "roderik-quantal64"
  config.vm.box_url = "https://github.com/downloads/roderik/VagrantQuantal64Box/quantal64.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :private_network, ip: "33.33.33.10"

  config.hostmanager.enabled = false

  # Assign this VM to a bridged network, allowing you to connect directly to a
  # network using the host's network device. This makes the VM appear as another
  # physical device on your network.

  # config.vm.network :bridged

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  # config.vm.forward_port 80, 8080

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"

  config.ssh.max_tries = 40
  config.ssh.timeout   = 120

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      :deploy => {
        :ssh_keys => [
          File.read(File.expand_path("~/.ssh/id_rsa.pub"))
        ],
        :databases => {
          :testdb => {
            :adapter  => "postgresql",
            :host     => "localhost" ,
            :username => "testdbuser",
            :password => "testdbpass"
          },
          :redis => {
            :host => "localhost",
            :port => 6379
          }
        },
        :applications => [{
          :type     => "rails"             ,
          :name     => "chef-deploy-rails" ,
          :database => :testdb             ,
          :port     => 8080                ,
          :hosts    => ["localhost"]       ,
          :vhosts   => [{
            :hosts => ["chef-deploy-rails.com", "*.chef-deploy-rails.com"],
            :cert  => "chef-deploy-rails.com" ,
          }] ,
          :repository => "git://github.com/boz/chef-deploy-webapp-rails-test.git",
        },{
          :type       => "nodejs"             ,
          :name       => "chef-deploy-nodejs" ,
          :port       => 9090                 ,
          :hosts      => ["localhost"]        ,
          :vhosts     => [{
            :hosts => ["chef-deploy-nodejs.com", "*.chef-deploy-nodejs.com"],
          }],
          :repository => "git://github.com/boz/chef-deploy-webapp-nodejs-test.git",
          :database   => :redis
        }],
        :certificates => {
          'chef-deploy-rails.com' => {
            :crt => File.read("certs/chef-deploy-rails.com.crt"),
            :key => File.read("certs/chef-deploy-rails.com.key"),
          },
          'chef-deploy-nodejs.com' => {
            :crt => File.read("certs/chef-deploy-nodejs.com.crt"),
            :key => File.read("certs/chef-deploy-nodejs.com.key"),
          },
        }
      },
      :monit => {
        :mailserver => {
          :username => "system@boz.sh",
          :password => ENV['SYSTEM_EMAIL_PASSWORD'],
        },
        :email => "notifications@boz.sh",
        :from  => "system@boz.sh",
      },
      :postgresql => {
        :password => { :postgres => "TESTONLY" }
      }
    }
    chef.run_list = [
     "recipe[deploy::monit]"         ,
     "recipe[deploy::db-master]"     ,
     "recipe[deploy::redis-server]"  ,
     "recipe[deploy::app-rails]"     ,
     "recipe[deploy::app-nodejs]"    ,
    ]
  end
end
