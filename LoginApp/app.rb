require 'sinatra'
require 'mongoid'
require 'haml'

Mongoid.load!("/home/qburst/LoginApp/mongoid.yml", :development)
class LoginApp < Sinatra::Application
  #def initialize
  	#puts "gugduihi"
  	#puts params
  	#super
	#end

end

require_relative 'model/user.rb'
require_relative 'controller/authentications_controller.rb'
