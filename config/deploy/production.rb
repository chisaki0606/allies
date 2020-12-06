set :rails_env, 'production'
set :stage, :production
server '13.230.203.183', user: 'ubuntu', roles: %w{app db web}