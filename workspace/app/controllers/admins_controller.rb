class AdminsController < ApplicationController
	def index
	end
	def show
		redirect_to admins_path
	end
	def edit
		@user=User.find(params[:id])
	end
	def update	
		@user=User.find(params[:id])
		if @user.update(params.require(:user).permit(:email, :name))
			redirect_to admins_path
		else 
			render 'edit'
		end
		
	end
	def edit_password
		@user=User.find(params[:id])
	end
	def update_password
		@user=User.find(params[:id])
		if @user.update(params.require(:user).permit(:password, :password_confirmation))		
			redirect_to home_password_change_path
		else 
			render 'edit_password'
		end
	end

end
