require 'sinatra'
require 'sinatra/session'
require 'active_record'
require 'haml'
require 'table_print'
require 'sinatra/flash'
require 'will_paginate'
require 'will_paginate/active_record'
require 'warden'
require 'bcrypt'
require 'sinatra/redirect_with_flash'
require "sinatra/activerecord"
enable :session




#Mysql2.load("/home/qburst/LoginApp/mongoid.yml", :development)
set :database, {
	adapter: "mysql2", 
	database: "activerecord",
	host:     'localhost',
  username: 'vishnuk',
  password: 'password'
}

class LoginApp < Sinatra::Application
	use Rack::Session::Cookie, secret: "IdoNotHaveAnySecret"
  #register Sinatra::Flash
	register Sinatra::ActiveRecordExtension
  
	use Warden::Manager do |manager|
    manager.default_strategies :password
    manager.failure_app = LoginApp
    manager.serialize_into_session {|logger| logger.id}
    manager.serialize_from_session {|id| Logger.find_by_id(id)}
  end

  Warden::Manager.before_failure do |env,opts|
    env['REQUEST_METHOD'] = 'POST'
  end

  Warden::Strategies.add(:password) do
    def valid?
      params["email"] || params["password"]
    end

    def authenticate!
      #puts "vjhvjbjk==========================================================================="
      logger = Logger.find_by_email(params["email"])
      if logger && logger.authenticate(params["password"])
        success!(logger)
      else
        fail!("Could not log in")
      end
		end
  end

  def page
    [params[:page].to_i - 1, 0].max
  end

  def tp_pre data, options={}
    TablePrint::Printer.new(data, options).table_print
  end

  
  def warden_handler
    env['warden']
  end

  def check_authentication
    #puts "inside check_authentication"
    unless warden_handler.authenticated?
      #puts "inside =============="
      redirect '/'
    end
  end

  def current_user
    warden_handler.logger
  end	
end


require_relative 'model/logger.rb'
require_relative 'model/login_history.rb'
require_relative 'controller/authentications_controller.rb'