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

require 'postmark'
require 'rufus-scheduler'
require 'resque'
require 'resque-scheduler'
require 'redis'




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

your_api_token = 'efc0dfeb-6f9c-41b4-8789-f2794c71e93f'
set :mailer , Postmark::ApiClient.new(your_api_token, http_open_timeout: 15)
class WebApp < Sinatra::Application
  enable :session
  set :bind, '10.7.60.17'
	set :port, 8080
  set :session_secret => 'So0perSeKr3t!'
	register Sinatra::Flash
	register Sinatra::ActiveRecordExtension
	#use Rack::Session::Cookie #,:secret => 'some_secret'
  G_API_CLIENT= ENV['G_API_CLIENT']
  G_API_SECRET= ENV['G_API_SECRET']
  
  #mailer = Postmark::ApiClient.new(your_api_token, http_open_timeout: 15)


  # scheduler = Rufus::Scheduler.new
  #   scheduler.every '1s' do
  #     nl = NewsLetter.find_by_schedule_at(Time.now)
  #     p nl
  #     unless nl.nil?        
  #       nl.recipients.each do |employee|
  #         @email = Employee.find_by_employee_id(employee).email
  def mail
    settings.mailer.deliver(from: 'vishnukulangara@qburst.com',
           to: 'vishnukulangara@qburst.com',
           subject: "nl.subject" ,
           text_body: "nl.content"             
           )
  end
  #       end
  #     end
      
  #   end

  def g_auth
    @email=session[:current_employee_email]
    #@access_token = session[:access_token]
    
    if @email=="" || @email.nil?
      
      access_token = client.auth_code.get_token(params[:code], :redirect_uri => redirect_uri)
      session[:access_token] = access_token.token
      @access_token = session[:access_token]
      mail = access_token.get('https://www.googleapis.com/userinfo/email?alt=json').parsed
      @email=mail.flatten[1].flatten[1]
      session[:current_employee_email]=@email
    end
  end

  def current_employee
    @email=session[:current_employee_email]
    current_employee=Employee.find_by_email(@email)
  end


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
        
        fail!("Could not log in")
      else
        
        puts employer
        if employer && employer.authenticate(params["password"])
          success!(employer)
          
          puts employer
          
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
require_relative 'models/news_letters.rb'
require_relative 'models/messages.rb'
require_relative 'models/assets.rb'
require_relative 'models/asset_categories.rb'
require_relative 'models/employees.rb'
require_relative 'models/companies.rb'
require_relative 'controllers/employer_controller.rb'
require_relative 'controllers/employee_controller.rb'
require_relative 'jobs/news_letter_job.rb'
