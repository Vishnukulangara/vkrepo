class SessionsController < ApplicationController
  def create
    client = Client.from_omniauth(env["omniauth.auth"])
    session[:client_id] = client.id
    @employee = Employee.find_by_email(current_employee.email)
    if @employee.nil?
    	redirect_to root_path
    else
    	redirect_to employee_dashboard_index_path
    end
  end

  def destroy
    session[:client_id] = nil
    redirect_to root_path
  end
end
