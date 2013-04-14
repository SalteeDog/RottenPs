class MoviesController < ApplicationController

 # @all_ratings = Movie.all_ratings
 # @all_ratings = ['pg','xx']
 # @selected_ratings = Movie.All_ratings
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.All_ratings

    # Session control
    @all_ratings_hash = @all_ratings.collect {|r|Hash[r,1]}
    # check if params are null - if so then use session params/rredirect
    if session[:sort] == nil then session[:sort] ="title"
      end
    if session[:ratings] == nil then session[:rratings] = @all_ratings_hash

    end
    if params[:sort] == nil and params[:ratings] == nil then
     params[:sort] = session[:sort]
     params[:ratings] = session[:ratings]
     flash.keep
     redirect_to movies_path :sort=>params[:sort],:ratings=>params[:ratings]

    else
    #else save params to session and continue as normal
     session[:sort] = params[:sort]
     session[:ratings] = params[:ratings]
    end
    # End of session control



    if @selected_ratings==nil
      @selected_ratings = @all_ratings
    end
    if params[:ratings]!=nil
      @selected_ratings = params[:ratings].keys
      @selected_ratings_hash = params[:ratings]
    end

#    puts @selected_ratings
#    @movies = Movie.where("rating = ?",params[:ratings].keys).order(params[:sort])
     @movies = Movie.where(:rating => @selected_ratings).order(params[:sort])
#    @highlight = Hash.new
    @highlight = {params[:sort]=>"hilite"}
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
