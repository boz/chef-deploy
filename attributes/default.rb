node.default.deploy.ssh_keys = []
node.default.deploy.username = 'deploy'

node.default.deploy.postgresql.data_directory = "/db/postgresql/main"

node.default.redis.confdir = "/etc/redis"
node.default.redis.datadir = "/db/redis/main"
node.default.redis.user    = "redis"
node.default.redis.group   = "redis"

node.default.monit.fs.fstypes   = %w{ext2 ext3 ext4 xfs}
node.default.monit.fs.mountopts = "rw"

node.default.monit.period             = 60

# set to "syslog" for syslog logging
node.default.monit.logfile            = "/var/log/monit.log"

node.default.monit.mailserver.host    = "smtp.gmail.com"
node.default.monit.mailserver.port    = 587
node.default.monit.mailserver.using   = "tlsv1"
node.default.monit.mailserver.timeout = 30

if node[:ec2]
  node.default.monit.hostname = node[:ec2][:public_hostname]
end

node.default.rsyslog.ssl       = false
node.default.rsyslog.crt       = "/etc/ssl/certs/rsyslog.crt"
node.default.rsyslog.statedir  = "/var/spool/rsyslog"

if node[:ec2]
  node.default.rsyslog.hostname = node[:ec2][:public_hostname]
end
