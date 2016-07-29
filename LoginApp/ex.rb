require 'sinatra'
require 'mongoid'
require 'haml'

Mongoid.load!("/home/qburst/LoginApp/mongoid.yml", :development)
class MyApp < Sinatra::Application

end

require_relative 'model/user.rb'
require_relative 'controller/routes.rb'
