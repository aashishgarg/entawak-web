# Instance Details
set :host_ip, '35.162.247.59'
set :domain, fetch(:host_ip)

# Rails Environment
set :rails_env, 'production'
set :ssl_enabled, false