class UsersController < ApplicationController
	def index
	end
	def login
		render 'new'
	end
	def show
		@user = User.find(params[:id])
	end
	def new
		@user = User.new

	end
	def edit
		@user = User.find(params[:id])
		@edit = "edit"
	end
	def create
		if params[:user]!= ""
			@user = User.new(user_params)
			pass_hash(params[:user][:password])
			@user.password= @pass
			
			if @user.save
				redirect_to @user
			else
				render 'new'
			end
		else
			render 'new'
		end

	end
	def update
		@user = User.find(params[:id])
		@user.update(user_params)		
			if @user.save
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
			params.require(:user).permit(:email, :name)
		end
		def pass_hash(password)
			@pass = Digest::MD5.hexdigest(password)
		end

end
