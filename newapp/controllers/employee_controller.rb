get "/login_employee" do
  redirect client.auth_code.authorize_url(:redirect_uri => redirect_uri,:scope => SCOPES,:access_type => "offline")
end

get '/oauth2callback' do
	g_auth  
  employee=Employee.find_by_email(@email)
  if employee.nil?
   	redirect '/unauthenticated'
  else
  	id= employee.employee_id
  	redirect "/employees/#{id}"
  end
end

get '/unauthenticated' do
  p session[:current_employee_email]
  flash[:failure] = "Incorrect email or password! "
  #flash[:failure]= "Please sign out of the current google account to login "
  
  redirect '/'
end

get '/employees/:id' do
  
  @id= params[:id]
  employee= Employee.find_by_employee_id(@id)
  if employee.nil?
    flash[:err4]= "Sorry you are not allowed to visit this page"
    redirect '/login_employee'
  else
    if employee == current_employee
      #employer=Employer.find_by_id(employee.employer_id)
      company = Company.find_by_id(employee.employer_id)
      @company= company.company_name
      p @company
      #flash[:msg4] = "welcome #{current_employee.name}"
      haml :employee
    else
      flash[:err4]= "Sorry , you are not allowed to visit the requested page. If you want to view #{employee.name}'s profile please search instead"
      redirect '/login_employee'
    end
  end
end

get '/employee/logout' do  
  session[:current_employee_email]=""
  redirect '/'
end

get "/employee/:id/update_info" do
  $id= params[:id]
  haml :update_profile
end

get "/employee/:id/update_profile" do
  employee= current_employee
  if params[:address] != ""
    employee.address = params[:address]
    employee.save
  end
  if params[:bank_account_details] != ""
    employee.bank_account_details = params[:bank_account_details]
    employee.save

  end
  if params[:passport_details] != ""
    employee.passport_details = params[:passport_details]
    employee.save
  end
  
  if params[:pancard_no] != ""
    employee.pancard_no = params[:pancard_no]
    employee.save
  end

  if params[:adhar_no] != ""
    employee.adhar_no = params[:adhar_no]
    employee.save
  end
  if params[:qualification_details] != ""
    employee.qualification_details = params[:qualification_details]
    employee.save
  end
  
  
  if employee.errors.empty?
    flash[:msg3] = " Employee Profile updated"
    redirect "/employees/#{current_employee.employee_id}"
  else
    flash[:err3] = "employee information not updated. Please redo"
    redirect "/employee/#{current_employee.employee_id}"
  end
end

get "/employee/asset/:id" do
  
  @id= params[:id]
  @code = current_employee.employee_id
  asset = Asset.find_by_asset_id(@id)
  if asset.employee_id== current_employee.employee_id
    haml :asset
  else 
    redirect "/employees/#{current_employer.employee_id}"
  end
end

get "/employee/search_employee" do
  @input = params[:search_employee]
  @code = current_employee.employee_id
  haml :search_employee
end

get "/employee/employee/:id" do
  @id = params[:id]
  haml :employee_employee
end