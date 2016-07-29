get '/' do
  haml :login_app
end

post'/login' do
  if User.where(username:params[:user]).exists?
    if User.where(password:params[:pw]).exists?
  	  haml :loggedin
  	else
  	  haml :relogin
  	end
  else 
    haml :relogin

  end 
end
post'/signup' do
  haml :signup
end
post "/signedup" do
 if params[:pword]!=""
   if params[:pword]==params[:pword1]
     user=User.new
     user.name=params[:name]
     user.username=params[:username]
     user.password=params[:pword]
     user.email=params[:mail] 
     user.save
     
     haml :loggedin
     
   else
     haml :re_signup
   end
 else
   haml :re_signup 
 end
end
post '/' do
  haml :valid
end

post '/logout' do
  haml :logout
end
post '/login/user' do 
  "hello"
end
post '/login/forgot_pw' do 
  "we'll do that later"
end