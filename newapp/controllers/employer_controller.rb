get '/' do 
	flash[:show] = "Please select your choice"
	haml :index
end

get '/login_employer' do 

	flash[:message] = "Please enter the fields with correct information"
	haml :login
end

get '/login_user' do 
	@code = "2"
	haml :login
end

get '/signup' do 
	flash[:msg] = "Please enter the fields with correct information"
	haml :signup
end


get '/employer' do
	env['warden'].authenticate!
	employer= current_employer
    if env['warden'].authenticated?
		flash.now[:message] = "welcome back !"

		haml :employer
	end
end

get "/employer/edit/:id" do
	check_authentication
	@id = params[:id]
	employer = Employer.find_by_id(@id)
	if employer.role ==1
		if params[:name]!= ""
			employer.name = params[:name]
			employer.save
		end
		if params[:email]!= ""
			employer.email = params[:email]
			employer.save
		end
	end
	if params[:password]!= "" || params[:password] == params[:password_confirmation]
		employer.password = params[:password]
		employer.save
	end
	if params[:password_confirmation]!= ""
		employer.password_confirmation = params[:password_confirmation]
		employer.save
	end
	redirect "/employer"
end


get '/new_employer' do
		
	employer = Employer.create({name:  params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation], company_name: params[:company_name], role: 1})
	
	if employer.errors.empty?
		
		flash[:message] = "Welcome "
		haml :new_employer
	else
		
		flash[:warning] ="signup error"	
		haml :signup
	end
	
end
get '/logout' do
	env['warden'].logout
	flash[:notice] = "you are successfully logged out"
	haml :index
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
	if company.nil?
		company=Company.find_by_id(current_employer.user_employer_id)
		if company.nil?
			company=Company.new
			company.employer_id=current_employer.user_employer_id
			company.save
		end
	else
		company.employer_id=current_employer.id
		company.save
		if params[:company_name] != "" 
			company.company_name = params[:company_name]
			company.save
		end

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

get "/employer/user/create" do 
	check_authentication
	haml :create_user
end

get'/employer/user/delete/:id' do 
	@id= params[:id]
	Employer.find_by_id(@id).delete
	redirect "/employer/users"
end

get '/employer/user/edit/:id' do
	check_authentication
	@id = params[:id]
	employer = Employer.find(@id)

	
	p params[:name]
	if params[:name] != ""
		p "11111#{employer.password}22222222222"
		employer.name = params[:name]
		employer.save
		p "11111#{employer.name}22222222222"
	end
	if params[:email]!=""
		employer.email = params[:email]
		employer.save
	end
	employer.save
	p "#{employer.name}"
	redirect "/employer/users"
end
get "/employer/user/create/" do 
	check_authentication
	user = Employer.create({name:  params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation], role: 2, user_employer_id: current_employer.id})
	
	if user.errors.empty?
		
		flash[:message] = "new user added "
		redirect "/employer/users"
	else
		
		flash[:warning] ="error please retry"	
		redirect "/employer/users"
	end
end




get "/employer/users/:id" do
	check_authentication
	@id = params[:id]
	haml :user
end


get "/employer/assets" do
	check_authentication 
	haml :employer_assets
end

get "/employer/assets/manage" do
	check_authentication
	haml :manage_assets
end

get "/employer/assets/create" do
	check_authentication
	haml :create_assets
end

get "/employer/assets/create/" do
	check_authentication
	@category = params[:category]
	@type= params[:type]
	@asset_name = params[:asset_name] 
	@working_condition = params[:working_condition]
	@specification = params[:specification]
	if @asset_name == "" || @category == "" || @working_condition =="" || @type ==""
		flash[:error] = "Please input valid data"
		redirect "/employer/assets/create"
	else
		ac= AssetCategory.where(asset_category: @category, asset_type: @type).first
		l_asset= Asset.where(asset_category: @category, asset_type: @type).last
		if ac.nil?
			cat = AssetCategory.where(asset_category: @category).first
			new_a_c= AssetCategory.create({asset_category: @category, asset_type: @type, type_id: 1})

			
			if cat.nil?
				last_cat=AssetCategory.order("category_id").last

				if last_cat.nil?
					new_a_c.category_id=1
				else

					new_a_c.category_id=(last_cat.category_id+1)
				end
			else

				new_a_c.category_id=cat.category_id
			end
			new_a_c.a_c_id= (new_a_c.category_id*10) + new_a_c.type_id
			new_a_c.save
			ac_id=new_a_c.a_c_id
			
		else 
			ac_id=ac.a_c_id
		end
		
		if l_asset.nil? 
			if current_employer.role==1
				calc = current_employer.id*1000000 + ac_id.to_i*1000
			else
				calc = current_employer.user_employer_id*1000000 + ac_id.to_i*1000
			end
		else
			calc= l_asset.asset_id
		end
		calc=calc.to_i
		if current_employer.role==1
			asset= Asset.create({employer_id: current_employer.id, employee_id: 0, asset_name: @asset_name, asset_category: @category,asset_type: @type, working_condition: @working_condition, specification: @specification, asset_id: (calc+1)})
		else
			asset= Asset.create({employer_id: current_employer.user_employer_id, employee_id: 0, asset_name: @asset_name, asset_category: @category,asset_type: @type, working_condition: @working_condition, specification: @specification, asset_id: (calc+1)})
		end
		if asset.errors.empty?
			flash[:success]= " New asset added!"
			
			redirect "/employer/assets/create"
		else
			flash[:error] = "Error! Please retry"
			redirect "/employer/assets/create"
		end
	end
end

get "/employer/assets/update" do
	check_authentication
	haml :update_assets
end

get "/employer/assets/update/" do
	check_authentication
	asset= Asset.find_by_asset_id(params[:asset_id].to_i)
	if asset.nil?
		flash[:error] = "Asset ID doesn't exists!"
		redirect "/employer/assets/update"
	else
		asset.employee_id= params[:assign_to]
		asset.save
		flash[:message] = "Asset is assigned to #{Employee.find_by_employee_id(params[:assign_to]).name}!"
		redirect "/employer/assets/update"
	end
end

get "/employer/asset/:id" do
	check_authentication
	@id= params[:id]
	@code = current_employer.id
	haml :asset
end

get '/employer/assets/:id/edit' do
	check_authentication
	@id= params[:id]
	haml :asset_edit
end

get '/employer/assets/:id/edit_asset' do
	check_authentication
	@id= params[:id]
	
	asset = Asset.find_by_asset_id(@id)
	if params[:asset_name] != ""
		asset.asset_name = params[:asset_name]
		asset.save

	end
	if params[:asset_category] != ""
		asset.asset_category = params[:asset_category]
		asset.save
	end
	if params[:asset_type] != ""
		asset.asset_type = params[:asset_type]
		asset.save
	end
	if params[:working_condition] != ""
		asset.working_condition = params[:working_condition]
		asset.save
	end

	if params[:specification] != ""
		asset.specification = params[:specification]
		asset.save
	end
	if params[:assign_to] != ""
		asset.employee_id= params[:assign_to]
		asset.save
	end
	
	
	if asset.errors.empty?
		flash[:msg3] = " asset information updated"
		redirect "/employer/assets"
	else
		flash[:err3] = "asset information not updated. Please redo"
		redirect "/employer/assets"
	end
end


get "/employer/assets/delete" do
	check_authentication
	haml :delete_assets
end

get "/employer/assets/:id/delete" do 
	check_authentication
	@id = params[:id]
	asset= Asset.find_by_asset_id(@id)
	asset.delete
	flash[:message] = "Asset is removed"
	redirect "/employer/assets/update"
end

get "/employer/assets/delete/" do
	check_authentication
	asset= Asset.find_by_asset_id(params[:asset_id].to_i)
	if asset.nil?
		flash[:error] = "Asset ID doesn't exists!"
		redirect "/employer/assets/delete"
	else
		asset.delete

		flash[:message] = "Asset is removed"
		redirect "/employer/assets/delete"
	end
	
end

get "/employer/assets/search_asset" do 
	check_authentication
	@tag = params[:search_asset]
	haml :search_assets
end

get "/employer/employee/new" do
	check_authentication
	e = Employee.where(employer_id: current_employer.id).last
	if e.nil?
		val= current_employer.id*1000
	else
		val=e.employee_id
	end
	employee = Employee.create({name: params[:name], employer_id: current_employer.id, date_of_birth: params[:dob], email: params[:email], address: params[:address], date_of_joining: params[:joining_date], employment_status: params[:status], section: params[:section] })
	if employee.errors.empty?
		employee.employee_id= (val.to_i+1)
		employee.save
		if employee.errors.empty?
			flash[:msg2] = "new employee added"
			#WEgKNKHKZIGaAAqpAB2y2A

			#e97e2795-4112-4927-920f-2b84e6df1dec
			settings.mailer.deliver(from: current_employer.email,
               to: params[:email],
               subject: "Job Confirmation",
               text_body: "Hi #{params[:name]} , 
               Welcome to #{current_employer.company_name}. Your joining_date is #{params[:joining_date]}.
               Thanks & Regards, 
               #{current_employer.name}	
               #{current_employer.company_name}")
               						  	
               							 	
			
			redirect "/employer/employee"

		else
			flash[:err2] = "employee creation failed. Please redo"
			redirect "/employer/employee"
		end
	else
		flash[:err2] = "employee creation failed. Please redo"
		redirect "/employer/employee"
	
	end
end


get "/employer/employee/:id" do 
	check_authentication
	$id= params[:id]
	if Employee.find_by_employee_id($id).nil?
		flash[:err5]= "Incorrect employee ID?"
		redirect "/employer/employee"
	else
		if current_employer.role ==1
			if Employee.find_by_employee_id($id).employer_id== current_employer.id
				haml :profile

			else
				flash[:err5]= "Incorrect employee ID?"
				redirect "/employer/employee"
			end		
		elsif current_employer.role ==2
			if Employee.find_by_employee_id($id).employer_id== current_employer.user_employer_id
				haml :profile

			else
				flash[:err5]= "Incorrect employee ID?"
				redirect "/employer"
			end	
		end	
	end
end

get "/employer/employee/delete/:id" do 
	check_authentication
	@id = params[:id]
	employee = Employee.find_by_employee_id(@id)
	if employee.employer_id == current_employer.id
		employee.delete
		flash[:message] = "Employee has been removed!"
		redirect "/employer/employee"
	else 
		flash[:error] = "Error. Please retry!"
		redirect "/employer/employee/#{@id}"
	end
end

get "/employer/employee/:id/edit" do 
	check_authentication
	$id= params[:id]
	haml :edit_profile
end

get "/employer/employee/send_mail/:id" do
	check_authentication
	@id= params[:id]
	haml :employer_mail
end

get "/employer/employee/mail/:id" do
	check_authentication
	@id= params[:id]
	employee= Employee.find_by_employee_id(@id)
	if employee.employer_id == current_employer.id

		settings.mailer.deliver(from: current_employer.email,
	               to: employee.email,
	               subject: params[:subject],
	               text_body: params[:content]             
	               )
		redirect "/employer/employee/#{@id}"
	else

		redirect "/employer"
	end
end

get "/employer/employee/:id/edit_employee" do
	check_authentication
	$id= params[:id]
	employee = Employee.find_by_employee_id($id)
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

get '/employer/search_employee' do 
	check_authentication
	@input = params[:search_employee]
	@code = current_employer.id
	haml :search_employee
end

get "/employer/employee/message/:id" do
	check_authentication
	@id = params[:id]
	haml :message
end

get "/employer/message/:id" do
	check_authentication
	@id = params[:id]
	@content = params[:message]
	if current_employer.role ==1 
		if @content != ""
			message = Message.create({sender_id: current_employer.id, reciever_id: @id, message: @content})
			if message.errors.empty?
				flash[:message] = " message has been sent" 
				redirect "/employer/employee/#{@id}"
			else
				flash[:message] = " message has not been sent"
				redirect "/employer/employee/message/#{@id}"
			end
		else
			flash[:message] = " message has not been sent"
				redirect "/employer/employee/message/#{@id}"
		end
	else
		redirect "/employer"
	end
end

get "/employer/message/archive/:id" do 
	check_authentication
	@id = params[:id]
	message = Message.find(@id)
	message.archive = 1
	message.save
	redirect "/employer"
end
 
get "/employer/message/unarchive/:id" do
	check_authentication
	@id = params[:id]
	message = Message.find(@id)
	message.archive = 0
	message.save
	redirect "/employer"
end

get '/employer/newsletter' do
	check_authentication
	haml :newsletter
end

get '/employer/newsletter/send' do
	check_authentication
	if current_employer.role ==1 
		if params[:all]=="on"
			scheduler = Rufus::Scheduler.new
			scheduler.at params[:schedule_at] do
			  Employee.where(employer_id: current_employer.id).find_each do |employee|
			  	settings.mailer.deliver(from: current_employer.email,
	               to: employee.email,
	               subject: params[:subject] ,
	               text_body: params[:area]             
	               )

			  # 	message = Message.create({sender_id: current_employer.id, reciever_id: employee.employee_id, message: params[:content]})
			  # 	if message.errors.empty?
					# 	flash[:message] = " message has been sent" 
					# 	redirect "/employer/newsletter"
					# else
					# 	flash[:message] = " message has not been sent"
					# 	redirect "/employer/newsletter"
					# end
					
				end
				
			end
			redirect "/employer/newsletter"
		else
			
			scheduler = Rufus::Scheduler.new
			scheduler.at params[:schedule_at] do
				Employee.where(employer_id: current_employer.id).find_each do |e|
					if params[:"#{e.employee_id}"]== "on"
						settings.mailer.deliver(from: current_employer.email,
	               to: e.email,
	               subject: params[:subject],
	               html_body: params[:area] )
						# message = Message.create({sender_id: current_employer.id, reciever_id: e.employee_id, message: params[:content]})
				  # 	if message.errors.empty?
						# 	flash[:message] = " message has been sent" 
						# 	redirect "/employer/newsletter"
						# else
						# 	flash[:message] = " message has not been sent"
						# 	redirect "/employer/newsletter"
						# end
						
					end
					
				end
				
			end
			redirect "/employer/newsletter"
		end
		
	end
end