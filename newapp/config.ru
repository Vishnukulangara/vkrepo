require_relative 'app.rb'
require 'resque/server'

#run WebApp

run Rack::URLMap.new \
  "/"       => WebApp.new,
  "/resque" => Resque::Server.new