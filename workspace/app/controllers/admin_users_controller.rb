class AdminUsersController < ApplicationController
	def index
	end
	
	def show
		@user = User.find(params[:id])
	end

	def new
		@user= User.new
	end
	
	def create
		@user=User.new(params.require(:user).permit(:email, :name, :password, :password_confirmation))
		@user.role ="user"
		if @user.save
			redirect_to admin_users_path
		else
			render 'new'
		end
	end
	def edit
		@user = User.find(params[:id])
	end
	def update
		@user = User.find(params[:id])
		@user.update(params.require(:user).permit(:email, :name))
		if @user.save
			redirect_to admin_user_path
		else 
			render 'edit'
		end
	end
	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to admin_users_path
	end
end
