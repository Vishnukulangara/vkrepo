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

     "You are successfully signed up! 
     <html><body><a href='/logout'>Logout<a></body></html> 
     "
   else
     haml :re_signup
   end
 else
   haml :re_signup 
 end
end
get '/login' do
  haml :valid
end

get '/logout' do
  haml :logout
end