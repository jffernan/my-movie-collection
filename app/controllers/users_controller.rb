class UsersController < ApplicationController
  get '/user/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/welcome'
  end

  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect to '/movies'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:password].empty? #if user inputs blank back to signup
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :password => params[:password]) #hash (params[:model])
      @user.save
      session[:user_id] = @user.id #set session for user by user_id
      erb 'users/welcome'
    end

    get '/login' do
      if !logged_in?
        erb :'users/login'
      else
        redirect to '/movies'
      end
    end

    post '/login' do
      user = User.find_by(:username => params[:username]) #username match
      if user && user.authenticate(params[:password]) #use bcrypt
        session[:user_id] = user.id #set session for user by user id
        redirect to '/movies'
      else
        redirect to '/error' #login invalid, display error msg
      end
    end

    get '/error' do
      erb :'users/error'
    end

    get '/logout' do
      if logged_in?
        session.clear
        redirect to '/login'
      else
        redirect to '/'
      end
    end

end
