require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm' # for rvm support. (http://rvm.io)
require 'yaml'
require 'io/console'

['base', 'nginx', 'mysql', 'check', 'crontab', 'log_rotate', 'product_deployment_sheet'].each do |pkg|
  require "#{File.join(__dir__, 'recipes', "#{pkg}")}"
end

set :application, 'entawak-web'
set :user, 'deploy'
set :deploy_to, "/home/#{fetch(:user)}/#{fetch(:application)}"
set :repository, repository_url
set :branch, set_branch
set :rvm_path, '/usr/local/rvm/scripts/rvm'

set :sheet_name, 'Product deployment status'
set :work_sheet_name, 'entawak-web'

set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml', 'config/cable.yml', 'config/sidekiq.yml')
set :shared_dirs, fetch(:shared_dirs, []).push('public/system', 'tmp/pids')

set :ruby_version, "#{File.readlines(File.join(__dir__, '..', '.ruby-version')).first.strip}"
set :gemset, "#{File.readlines(File.join(__dir__, '..', '.ruby-gemset')).first.strip}"

task :environment do
  set :rails_env, ENV['on'].to_sym unless ENV['on'].nil?
  require "#{File.join(__dir__, 'deploy', "#{fetch(:rails_env)}_configurations_files", "#{fetch(:rails_env)}.rb")}"
  invoke :'rvm:use', "#{fetch(:ruby_version)}@#{fetch(:gemset)}"
end
task :setup => :environment do
  invoke :set_sudo_password
  command %[mkdir -p "#{fetch(:shared_dir)}/log"]
  command %[chmod g+rx,u+rwx "#{fetch(:shared_dir)}/log"]

  command %[mkdir -p "#{fetch(:shared_dir)}/config"]
  command %[chmod g+rx,u+rwx "#{fetch(:shared_dir)}/config"]

  command %[mkdir -p "#{fetch(:shared_dir)}/tmp/pids"]
  command %[chmod g+rx,u+rwx "#{fetch(:shared_dir)}/tmp/pids"]

  command %[mkdir -p "#{fetch(:shared_dirs)}/public/system"]
  command %[chmod g+rx,u+rwx "#{fetch(:shared_dirs)}/public/system"]

  command %[touch "#{fetch(:shared_dir)}/config/database.yml"]
  invoke :setup_prerequesties
  invoke :setup_yml
  # comment %["-----> Be sure to edit 'shared/config/*.yml files'."]
end

task :setup_prerequesties => :environment do
  # comment "-----> Installing development dependencies"
  [
      'python-software-properties', 'libmysqlclient-dev', 'imagemagick', 'libmagickwand-dev', 'nodejs',
      'build-essential', 'zlib1g-dev', 'libssl-dev', 'libreadline-dev', 'libyaml-dev', 'libcurl4-openssl-dev', 'curl',
      'git-core', 'make', 'gcc', 'g++', 'pkg-config', 'libfuse-dev', 'libxml2-dev', 'zip', 'libtool', 'memcached',
      'xvfb', 'mysql-client', 'mysql-server', 'mime-support', 'automake'
  ].each do |package|
    comment "Installing #{package}"
    command %[sudo -A apt-get install -y #{package}]
  end

  # comment "-----> Installing Ruby Version Manager"
  command %[command curl -sSL https://rvm.io/mpapis.asc | gpg --import]
  command %[curl -sSL https://get.rvm.io | bash -s stable --ruby]

  command %[source "#{fetch(:rvm_path)}"]
  command %[rvm requirements]
  command %[rvm install "#{fetch(:ruby_version)}"]
  command %[gem install bundler]
  command %[mkdir "#{fetch(:deploy_to)}"]
  command %[chown -R "#{fetch(:user)}" "#{fetch(:deploy_to)}"]
  # #setup nginx
  invoke :'nginx:install'
  # #setup nginx
  invoke :'nginx:setup'
  invoke :'nginx:restart'

end

task :setup_yml => :environment do
  # invoke :set_sudo_password
  Dir[File.join(__dir__, '*.yml.example')].each do |_path|
    command %[echo "#{erb _path}" > "#{File.join(fetch(:deploy_to), 'shared/config', File.basename(_path, '.yml.example') +'.yml')}"]
  end
end

desc "Deploys the current version to the server."
task :deploy => :environment do


  deploy do
    invoke :'check:revision'
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'mysql:create_database'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    # command %[ln -s "#{fetch(:deploy_to)}/shared/pids" tmp/.]
  end
  on :launch do
  end
  invoke :restart
end


task :set_sudo_password => :environment do
  command "echo \"#{erb(File.join(__dir__, 'deploy', "#{fetch(:rails_env)}_configurations_files", 'sudo_password.erb'))}\" > /home/#{fetch(:user)}/SudoPass.sh"
  command "chmod +x /home/#{fetch(:user)}/SudoPass.sh"
  command "export SUDO_ASKPASS=/home/#{fetch(:user)}/SudoPass.sh"
end

desc 'Restart passenger server'
task :restart => :environment do
  invoke :set_sudo_password
  invoke :'crontab:install'
  command %[ps -ef | grep sidekiq | grep -v grep | awk '{print $2}' | xargs kill -9]

  command %[sudo -A service nginx restart]
  comment "----------------------------- Start Passenger"
  command %[mkdir -p #{File.join(fetch(:current_path), 'tmp')}]
  command %[touch #{File.join(fetch(:current_path), 'tmp', 'restart.txt')}]
  invoke :'rvm:use', "#{fetch(:ruby_version)}@#{fetch(:gemset)}"
  command %[cd #{File.join(fetch(:current_path))} && RAILS_ENV=#{fetch(:rails_env)} bundle exec sidekiq  -C config/sidekiq.yml -L log/sidekiq.log -d]
  invoke :'product_deployment_sheet:update'
end