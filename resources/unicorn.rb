actions :install, :start, :stop, :restart
default_action :install

attribute :name             , :kind_of => String
attribute :user             , :kind_of => String
attribute :directory        , :kind_of => String
attribute :environment      , :kind_of => String

attribute :port             , :kind_of => [Integer,String]
attribute :worker_timeout   , :kind_of => Integer, :default => 60
attribute :preload_app      , :kind_of => [TrueClass, FalseClass], :default => false
attribute :worker_processes , :kind_of => Integer, :default => [node['cpu']['total'].to_i * 4, 8].min
attribute :syslog           , :kind_of => [TrueClass,FalseClass,NilClass], :default => false
attribute(:before_fork      , :kind_of => String , :default => %{
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
})
attribute(:after_fork       , :kind_of => String , :default => %{
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to sent QUIT'
  end
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
})
