 Dir["/home/qburst/vkrepo/workspace/app/jobs/*.rb"].each { |file| require file }
# ENV["REDISTOGO_URL"] ||= "redis://redistogo:a1140683b3ed3d9dddb4613217b502d5@sculpin.redistogo.com:9629/
# "

# uri = URI.parse(ENV["REDISTOGO_URL"])
# Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)
rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
rails_env = ENV['RAILS_ENV'] || 'development'

resque_config = YAML.load_file(rails_root + '/config/resque.yml')
Resque.redis = 'localhost:6379'