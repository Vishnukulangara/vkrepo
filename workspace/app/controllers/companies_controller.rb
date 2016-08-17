class CompaniesController < ApplicationController
	def index
		@company = Company.first
	end
	def edit
		@company = Company.first
	end
	def update
		@company = Company.first
		if @company.update(params.require(:company).permit(:name, :website, :address))
			redirect_to companies_path
		else
			render 'edit'
		end
	end
end
