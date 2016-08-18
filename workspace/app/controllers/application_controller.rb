class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_employee
  your_api_token = 'efc0dfeb-6f9c-41b4-8789-f2794c71e93f'
  mailer = Postmark::ApiClient.new(your_api_token, http_open_timeout: 15)

  def current_employee
    @current_employee ||= Client.find(session[:client_id]) if session[:client_id]
  end

  # def after_sign_out_path_for(user)
  # 	render 'devise/sessions#new' 
  # end

  def after_sign_in_path_for(user)
  	'/admins'
  end
end
