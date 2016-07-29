require 'sinatra'
require 'active_record'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'warden'
require 'bcrypt'
require 'sinatra/session'
require 'json'
require 'oauth2'



enable :session

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
	register Sinatra::Flash
	register Sinatra::ActiveRecordExtension
	use Rack::Session::Cookie, secret: "IdoNotHaveAnySecret"

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
      if employer && employer.authenticate(params["password"])
        success!(employer)
      else
        fail!("Could not log in")
      end
	 end
  end

  def current_employer
    env['warden'].employer
  end

  def redirect_uri
    uri = URI.parse(request.url)
    uri.path = '/oauth2callback'
    uri.query = nil
    uri.to_s
  end

end

require_relative 'models/employers.rb'

require_relative 'controllers/employer_controller.rb'
