include_attribute "rvm"

node.override.build_essential.compiletime = true
node.default.deploy.ssh_keys = []
node.default.deploy.username = 'deploy'

node.default.deploy.postgresql.data_directory = "/db/postgresql/main"

node.default.deploy.base_gems = [
  { 'name' => "bundler" },
  { 'name' => 'rubygems-bundler', 'action' => 'remove' },
]

node.default.deploy.gems = [
  { 'name' => 'pg'   , :version => '~> 0.14.1' },
  { 'name' => 'rails', :version => '~> 3.2.11' },
]
