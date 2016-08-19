class MessagesController < ApplicationController
	def index
		Message.where(message: 'deleted', message_copy: 'deleted').find_each do |m|
			m.destroy
		end

	end
	def new 
		@message = Message.new
	end
	def create
		@message = Message.new
		@message.message= params[:message][:message]
		@message.message_copy= params[:message][:message]
		if current_employee
			@message.sender_id = Employee.find_by_email(current_employee.email).id
			@message.reciever_id = 1
		else
			@message.sender_id = 1
			@message.reciever_id = params[:message][:reciever_id]
		end
		@message.archive = 0
		if @message.save
			redirect_to messages_path
		else
			render 'message'
		end
	end
	def show
		@message = Message.find(params[:id])
	end
	def archive
		@message = Message.find(params[:id])
		@message.archive = 1
		if	@message.save
			redirect_to messages_path
		else
			admins_path
		end
		
	end
	def unarchive
		@message = Message.find(params[:id])
		@message.archive = 0
		if	@message.save
			redirect_to messages_path
		else
			admins_path
		end
		
	end

	def destroy
		@message = Message.find(params[:id])
		if current_user
			@message.message = 'deleted'
			@message.save
			redirect_to messages_path
		elsif current_employee
			@message.message_copy = 'deleted'
			@message.save
			redirect_to messages_path
		end
	end
	def to_employee
		@employee = Employee.find(params[:id])
	end
	def send_msg
		@employee = Employee.find(params[:id])
		@message = Message.new
		@message.message= params[:message][:message]
		@message.message_copy= params[:message][:message]
		@message.sender_id = 1
		@message.reciever_id = @employee.id
		@message.archive = 0
		if @message.save
			redirect_to messages_path
		else
			render 'message'
		end

	end
end
