
  get '/' do
    haml :login_app
  end

  post'/login' do
    env['warden'].authenticate!
    logger = env['warden'].logger
    if env['warden'].authenticated?
      LoginHistory.create({user_id: logger.id, login_time: Time.now})
      # puts "jygjkgbjkbhjkhkjh"
      # puts logger
      #puts env['warden'].current_user
      flash[:success] = "you ==============================================just logged in !!"
      haml :loggedin
    else 

      redirect '/'
    end 
  end

  post'/signup' do
    flash.now[:message] ="pls sign up===================="
    haml :signup
  end

  post "/signedup" do
    #if params[:email]!="" && params[:password]!="" && params[:password_confirmation]!="" && params[:mobile_no]!="" && params[:first_name]!="" && params[:password]==params[:password_confirmation]
      
      logger=logger.create({first_name: "#{params[:first_name]}", last_name: "#{params[:last_name]}", email:"#{params[:email]}", password: "#{params[:password]}", password_confirmation: "#{params[:password_confirmation]}", mobile_no: params[:mobile_no]})
      
      puts logger.errors.full_messages
      if logger.errors.empty?
            
        haml :loggedin
         
      else
        
        haml :re_signup
      end
    # else
    #   haml :re_signup
    # end  
    
  end

  get '/logout' do
    logger = env['warden'].logger
    env['warden'].logout
    login_history = LoginHistory.where(user_id: logger.id ).last
    login_history.logout_time = Time.now
    duration = login_history.logout_time - login_history.login_time
    login_history.session_duration = duration
    login_history.save
    
    haml :logout

  end

  

  get '/login/logger' do 
    check_authentication
    @login_histories = LoginHistory.order(:id).paginate(:page => params[:page], :per_page => 5)

    haml :historyy

    #{}"#{tp LoginHistory.all}"    
  end

  # post '/login/forgot_pw' do
  #   check_authentication 
  #   "we'll do that later"
  # end

  post '/unauthenticated' do
    flash[:failure] = "ewahhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"
    redirect '/'
  end
