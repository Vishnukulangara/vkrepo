class EmployeesController < ApplicationController
	def index
		@employees = Employee.all
	end
	def show
		@employee = Employee.find(params[:id])
	end
	def new
		@employee = Employee.new
	end
	def edit
		@employee = Employee.find(params[:id])
	end
	def create
		your_api_token = 'efc0dfeb-6f9c-41b4-8789-f2794c71e93f'
  		mailer= Postmark::ApiClient.new(your_api_token, http_open_timeout: 15)
		@employee = Employee.new(employee_params)

		if @employee.save
			mailer.deliver(from: 'vishnukulangara@qburst.com' , 
				to: @employee.email, 
				subject: "Job Confirmation",
               	text_body: "Hi #{@employee.name} , 
               Welcome to #{Company.first.name}. Your joining_date is #{@employee.date_of_joining}.
               Thanks & Regards, 
               #{current_user.name}	
               #{Company.first.name}")
			redirect_to employee_path(@employee)
		else 
			render 'new'
		end
	end
	def update
		@employee = Employee.find(params[:id])
		if @employee.update(employee_params)
			redirect_to employee_path(@employee)
		else
			render 'edit'
		end
	end
	def destroy
		@employee = Employee.find(params[:id])
		@employee.destroy
		redirect_to employees_path
	end
	def compose_mail
		@employee = Employee.find(params[:id])
	end
	def send_mail
		your_api_token = 'efc0dfeb-6f9c-41b4-8789-f2794c71e93f'
  		mailer= Postmark::ApiClient.new(your_api_token, http_open_timeout: 15)
		@employee = Employee.find(params[:id])
		if params[:mail][:subject] !="" && params[:mail][:content] !="" 
			if mailer.deliver(
				from: 'vishnukulangara@qburst.com',
				to: @employee.email,
				subject: params[:mail][:subject],
	            html_body:params[:mail][:content])
				redirect_to employee_path(@employee)
			else
				redirect_to employees_path
			end
		else
			render 'compose_mail'
		end

	end
	private
		def employee_params
			params.require(:employee).permit(:name, :email, :mobile_no, :date_of_joining, :employment_status, :section)
		end
end