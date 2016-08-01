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
get '/employer' do
	env['warden'].authenticate!
	employer= current_employer
    #p employer
    if env['warden'].authenticated?
		flash.now[:message] = "welcome back !"
		haml :employer
	end
end
get '/new_employer' do
		
	employer = Employer.create({name:  params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation], company_name: params[:company_name]})
	
	if employer.errors.empty?
		
		flash[:message] = "Welcome "
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
get '/employer/edit_info' do
	check_authentication 
	haml :edit_info
end

get "/employer/edit_info/" do
	check_authentication
	company= Company.find_by_id(current_employer.id)
	company.employer_id=current_employer.id
	company.save
	if params[:company_name] != ""
		company.company_name = params[:company_name]
		company.save

	end
	if params[:company_website] != ""
		company.company_website = params[:company_website]
		company.save
	end
	if params[:company_address] != ""
		company.company_address = params[:company_address]
		company.save
	end
	redirect "/employer"
end


get "/employer/employee" do
	check_authentication
	#@employees = Employee.order(:id).paginate(:page => params[:page], :per_page => 10)
	haml :employer_employee
end

get "/employer/users" do
	check_authentication
	haml :employer_user
end
get "/employer/assets" do
	check_authentication 
	haml :employer_assets
end
get "/employer/employee/new" do
	check_authentication
	employee = Employee.create({name: params[:name], employer_id: current_employer.id, date_of_birth: params[:dob], email: params[:email], address: params[:address], date_of_joining: params[:joining_date], employment_status: params[:status], section: params[:section] })
	if employee.errors.empty?
		flash[:msg2] = "new employee added"
		redirect "/employer/employee"
	else
		flash[:err2] = "employee creation failed. Please redo"
		redirect "/employer/employee"
	end
end
get "/employer/employee/:id" do 
	check_authentication
	$id= params[:id]
	$id
	haml :profile
end
get "/employer/employee/:id/edit" do 
	check_authentication
	$id= params[:id]
	haml :edit_profile
end

get "/employer/employee/:id/edit_employee" do
	check_authentication
	$id= params[:id]
	employee = Employee.find_by_id($id)
	if params[:name] != ""
		employee.name = params[:name]
		employee.save

	end
	if params[:email] != ""
		employee.email = params[:email]
		employee.save
	end
	if params[:address] != ""
		employee.address = params[:address]
		employee.save
	end
	if params[:dob] != ""
		employee.date_of_birth = params[:dob]
		employee.save
	end

	if params[:section] != ""
		employee.section = params[:section]
		employee.save
	end
	if params[:status] != ""
		employee.employment_status = params[:status]
		employee.save
	end
	if params[:joining_date] != ""
		employee.date_of_joining = params[:joining_date]
		employee.save
	end
	
	if employee.errors.empty?
		flash[:msg3] = " employee information updated"
		redirect "/employer/employee"
	else
		flash[:err3] = "employee information not updated. Please redo"
		redirect "/employer/employee"
	end
end