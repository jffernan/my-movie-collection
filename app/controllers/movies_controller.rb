class MoviesController < ApplicationController
  get '/movies' do
   if logged_in? #show only logged_in CURRENT user's movies by alphabetized list
     @movies = current_user.movies.all.alphabetical_order #defined ActiveRecord method in model.rb
     erb :'movies/movies'
   else
     redirect to '/login'
   end
 end

 get '/movies/all' do
   if logged_in? #show all movies by users by alphabetized list
     @movies = Movie.all.alphabetical_order #defined ActiveRecord method in model.rb
     erb :'movies/all'
   else
     redirect to '/login'
   end
 end

 get '/movies/new' do
   if logged_in?
     erb :'movies/new'
   else
     redirect to '/login'
   end
 end

 post '/movies' do
   if params[:title].empty? || #If to test if user enters inputs
     params[:comment].empty? ||
     params[:date_purchased].empty? == ""
     redirect to '/movies/new'
   end
   @movie = Movie.new(
   title: params[:title],
   comment: params[:comment],
   date_purchased: params[:date_purchased],
   user_id: current_user.id)
   @movie.save
   redirect to "/movies/#{@movie.id}"
 end

  get '/movies/:id' do
    if logged_in?
      @movie = Movie.find_by_id(params[:id])
      erb :'movies/show'
    else
      redirect to '/login'
    end
  end

get '/movies/:id/edit' do
 if logged_in?
   @movie = Movie.find_by_id(params[:id])
   if @movie && @movie.user_id == current_user.id
     erb :'movies/edit'
   else
     redirect to "/movies/#{params[:id]}" #Test user can't edit another user movie
   end
 else
   redirect to '/login'
 end

end
