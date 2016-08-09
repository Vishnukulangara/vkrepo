class NewsLetterJob< WebApp
  @queue = :mail
  your_api_token = 'efc0dfeb-6f9c-41b4-8789-f2794c71e93f'
	set :mailer , Postmark::ApiClient.new(your_api_token, http_open_timeout: 15)

  def self.perform(subject, content, employer, employee)
	 	p "1111111111111133333311111111111111"
  	settings.mailer.deliver(from: employer, to: employee, subject: subject , html_body: content)    
  	puts "finished 222222222222222222222222222222 sending mails"
  
  end
end

