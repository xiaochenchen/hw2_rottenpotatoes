class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings

    key = params[:key]
    case key
    when 'title'
      @title_class = 'hilite'
    when 'release_date'
      @release_date_class = 'hilite'
    end
    
    #@movies = Movie.where(rating: ratings).order(key)
    if params[:commit] == 'Refresh'
      @ratings = params[:ratings].nil? ? {} : params[:ratings]
      session[:ratings] = @ratings
    else
      @ratings = session[:ratings] unless key.nil?
    end

    if @ratings.nil?
      @movies = Movie.order(key)
    else
      @movies = Movie.where(rating: @ratings.keys).order(key)
    end
    
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
