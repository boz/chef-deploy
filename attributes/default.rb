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
node.default.monit.mailserver.host    = "smtp.gmail.com"
node.default.monit.mailserver.port    = 587
node.default.monit.mailserver.using   = "tlsv1"
node.default.monit.mailserver.timeout = 30

