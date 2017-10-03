#========== Instance Details===============#
set :host_ip, ''
set :domain, fetch(:host_ip)
#==========================================#

#===============Rails Environment =========#
set :rails_env, 'staging'
set :ssl_enabled, false
#==========================================#