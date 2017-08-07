class MoviesController < ApplicationController
  get '/movies' do
    redirect to '/login' if !logged_in?
    @movies = current_user.movies.all.alphabetical_order #defined ActiveRecord method in model.rb
    erb :'movies/movies'
  end
  
  get '/movies/all' do
    redirect to '/login' if !logged_in?
    @movies = Movie.all.alphabetical_order #defined ActiveRecord method in model.rb
    erb :'movies/all'
  end

  get '/movies/new' do
    redirect to '/login' if !logged_in? 
    erb :'movies/new'
  end

  post '/movies' do
    redirect to '/login' if !logged_in?
    if params[:title].empty? || params[:comment].empty?
      redirect to '/movies/new'
    end
    @movie = current_user.movies.build(params)
    if @movie.save
      redirect to "/movies/#{@movie.id}"
    else 
      redirect to '/movies/new'
    end
  end

  get '/movies/:id' do
    redirect to '/login' if !logged_in?
    @movie = Movie.find_by_id(params[:id])
    erb :'movies/show'
  end

  get '/movies/:id/edit' do
   redirect to '/login' if !logged_in?
   @movie = Movie.find_by_id(params[:id])
   if @movie && @movie.user_id == current_user.id
     erb :'movies/edit'
   else
     redirect to "/movies/#{params[:id]}" #Test user can't edit another user movie
   end
 end

 patch '/movies/:id' do	
   redirect to '/login' if !logged_in?
   if params[:title].empty? || params[:comment].empty?
      redirect to "/movies/#{params[:id]}/edit"
   end
   @movie = Movie.find_by_id(params[:id])
      if @movie && @movie.user_id == current_user.id 
        if @movie.update(params)
          redirect to "/movies/#{params[:id]}"
        else 
          redirect to "/movies/#{params[:id]}/edit"
        end
      end
  end

  delete '/movies/:id/delete' do
    redirect to '/login' if !logged_in?
    @movie = Movie.find_by_id(params[:id])
    if @movie.user_id == current_user.id
      @movie.delete
      redirect to '/movies'
    else
      redirect to "/movies/#{params[:id]}"
    end
  end

end
