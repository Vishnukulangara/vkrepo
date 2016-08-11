class UsersController < ApplicationController

	def index
	end

	def auth
		@user = User.find_by(email: params[:user][:email])
		
		unless @user.nil?
			if @user.password==params[:user][:password]
				redirect_to @user
			else
				render 'index'
			end
		else
			render 'index'
		end
	end
	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def edit
		@user = User.find(params[:id])
	end

	def create

		if params[:user][:password_confirmation]!=""
			@user = User.new(user_params)
			if @user.save
				redirect_to @user
			else 
				render 'new'
			end
		else
			@user= User.new
			@user.save 
			render 'new'
		end
	end

	def update
		@user = User.find(params[:id])
	 
	  if @user.update(params.require(:user).permit(:name, :email, :mobile_no))
	    redirect_to @user
	  else
	    render 'edit'
	  end
	end

	def destroy
		@user = User.find(params[:id])
	  @user.destroy
	 
	  redirect_to users_path
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :mobile_no, :password, :password_confirmation)		
		end
end
