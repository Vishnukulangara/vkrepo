class EmployeeDashboardController < ApplicationController
  def index
	end
  def profile
  end
  def search_employee
  	@flag = 0
  end
  def employee_asset
  end
  def show_asset
  	@asset= Asset.find(params[:id])
  end
  def edit
  	@employee = Employee.find_by_email(current_employee.email)
  end
  def update
  	@employee = Employee.find_by_email(current_employee.email)
  	if @employee.update(params.require(:employee).permit(:address, :date_of_birth, :mobile_no, :bank_account_details, :passport_details, :pancard_details, :qualifications, :adhar_card_details))
  		redirect_to "/employee_dashboard/profile/#{@employee.id}"
  	else
  		render 'edit'
  	end
  end
end
