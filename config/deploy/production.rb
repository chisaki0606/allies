set :branch, "main"
set :stage, :production
set :rails_env, :production
server '13.230.203.183', user: 'ubuntu', roles: %w{app db web}