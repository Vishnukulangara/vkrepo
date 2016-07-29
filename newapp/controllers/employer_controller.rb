get '/' do 
	flash[:show] = "Please select your choice"
	haml :index
end

get '/login_employer' do 
	flash[:message] = "Please enter the fields with correct information"
	haml :login
end

get '/signup' do 
	flash[:msg] = "Please enter the fields with correct information"
	haml :signup
end
get '/login/:company_name' do
	env['warden'].authenticate!
    #employer = current_employer
    if env['warden'].authenticated?
		flash[:message] = "welcome back !"
		haml :employer
	end
end
get '/login/new_employer' do
		
	employer = Employer.create({name:  params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation], company_name: params[:company_name], company_address: params[:company_address], company_website: params[:company_website], image_path: params[:image_path]})
	if employer.errors.empty?
		flash[:message] = "Welcome #{:name}"
		haml :new_employer
	else
		flash[:warning] ="signup error"	
		haml :signup
	end
	
end

 get '/unauthenticated' do
	flash[:error] = "Incorrect email or password! "
	redirect '/login_employer'
end 

get '/logout' do
	env['warden'].logout
	flash[:notice] = "you are successfully logged out"
	haml :index
end

get "/login_employee" do
  redirect client.auth_code.authorize_url(:redirect_uri => redirect_uri,:scope => SCOPES,:access_type => "offline")
end

get '/oauth2callback' do
  access_token = client.auth_code.get_token(params[:code], :redirect_uri => redirect_uri)
  session[:access_token] = access_token.token
  @access_token = session[:access_token]
  
  # parsed is a handy method on an OAuth2::Response object that will 
  
  mail = access_token.get('https://www.googleapis.com/userinfo/email?alt=json').parsed
  @email=mail.flatten[1].flatten[1]
  # employer=Employer.find_by_email(@email)
  # if employer.nil?
  # 	redirect '/unauthenticated'
  
  # else
  haml :employee
  #end
end

post '/unauthenticated' do
    flash[:failure] = "error logging in"
    redirect '/login_employer'
end
