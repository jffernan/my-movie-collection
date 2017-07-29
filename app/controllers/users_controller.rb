class UsersController < ApplicationController
  get '/user/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/welcome'
  end

  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect to '/movies' #back to home
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
  end

end
