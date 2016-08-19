class Mailer
  @queue = :mail  
  	your_api_token = 'efc0dfeb-6f9c-41b4-8789-f2794c71e93f'
		mailer = Postmark::ApiClient.new(your_api_token, http_open_timeout: 15)
  def self.perform( subject, content, employer, employee)	
  	mailer.deliver(from: 'vishnukulangara@qburst.com', to: employee, subject: "Newsletter" , html_body: content)    
  end
end
