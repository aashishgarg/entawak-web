#========== Instance Details===============#
set :host_ip, '52.40.153.144'
set :domain, fetch(:host_ip)
#==========================================#

#===============Rails Environment =========#
set :rails_env, 'staging'
set :ssl_enabled, false
#==========================================#