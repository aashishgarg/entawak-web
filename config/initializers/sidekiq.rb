_path = File.join(Rails.root, 'config', 'sidekiq.yml')
if File.exists? _path
  conf = YAML.load_file(_path)
else
  raise Errno::ENOENT
end

Sidekiq.configure_server do |config|
  config.redis = {:size => conf[:size], :url => conf[:url]}
end
Sidekiq.configure_client do |config|
  config.redis = {:size => conf[:size], :url => conf[:url]}
end