require 'sinatra'
require 'active_record'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'warden'
require 'bcrypt'
require 'sinatra/session'
require 'json'
require 'oauth2'
require 'table_print'
require 'will_paginate'
require 'will_paginate/active_record'



#enable :session


ENV['G_API_CLIENT'] = "66767194447-65ldsf30as6ens5ogge9kpfrp1qnnfb6.apps.googleusercontent.com"
ENV['G_API_SECRET'] = "vlPk02jP4TuEk-WI3QJLbUa4"

SCOPES = [
    'https://mail.google.com/',
    'https://www.googleapis.com/auth/userinfo.email'
].join(' ')


set :database, {
	adapter: "mysql2", 
	database: "activerecord",
	host:     'localhost',
  username: 'vishnuk',
  password: 'password'
}

class WebApp < Sinatra::Application
  enable :session
  set :session_secret => 'So0perSeKr3t!'
	register Sinatra::Flash
	register Sinatra::ActiveRecordExtension
	#use Rack::Session::Cookie #,:secret => 'some_secret'
  G_API_CLIENT= ENV['G_API_CLIENT']
  G_API_SECRET= ENV['G_API_SECRET']

  def client
    client ||= OAuth2::Client.new(G_API_CLIENT, G_API_SECRET, {
                :site => 'https://accounts.google.com', 
                :authorize_url => "/o/oauth2/auth", 
                :token_url => "/o/oauth2/token"
              })
  end

	use Warden::Manager do |manager|
    manager.default_strategies :password
    manager.failure_app = WebApp
    manager.serialize_into_session {|employer| employer.id}
    manager.serialize_from_session {|id| Employer.find_by_id(id)}
  end

  Warden::Manager.before_failure do |env,opts|
    env['REQUEST_METHOD'] = 'POST'
  end

  Warden::Strategies.add(:password) do
    def valid?
      params["email"] || params["password"]
    end

    def authenticate!
      employer = Employer.find_by_email(params["email"])
      if employer.nil?
        puts "-------------------------------------"
        fail!("Could not log in")
      else
        puts "***************************"
        puts employer
        if employer && employer.authenticate(params["password"])
          success!(employer)
          puts "================================"
          puts employer
          p "++++++++++++++++++++++++++++++++++++++++++++++++++====================================="
          #p env['warden'].session_serializer
          #p env['warden'].session[:employer]
          
        else
          fail!("Could not log in")
        end
      end
	 end
  end

  def tp_pre data, options={}
    TablePrint::Printer.new(data, options).table_print
  end

  def current_employer
    env['warden'].user
  end

  def check_authentication
    unless env['warden'].authenticated?      
      redirect '/login_employer'
    end
  end

  def redirect_uri
    uri = URI.parse(request.url)
    uri.path = '/oauth2callback'
    uri.query = nil
    uri.to_s
  end

end

require_relative 'models/employers.rb'
require_relative 'models/employees.rb'
require_relative 'models/companies.rb'
require_relative 'controllers/employer_controller.rb'
