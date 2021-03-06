class MoviesController < ApplicationController
  
  def movie_params
    params.require(:movie).permit(:title, :rating, :director, :release_date)
  end

  def show
    puts 'Exercising "show" path'
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
    @director = @movie[:director] # put the director into a global used by show.html.haml
    # but if it is an empty string, set it to nil instead
    @director = nil if @director && 0 == @director.length
    #puts "Details for " + @movie[:title].to_s
  end

  def index
    puts 'Exercising "index" path'
    sort = params[:sort] || session[:sort]
    case sort
    when 'title'
      ordering,@title_header = {:title => :asc}, 'hilite'
    when 'release_date'
      ordering,@date_header = {:release_date => :asc}, 'hilite'
    end
    @all_ratings = Movie.all_ratings
    @selected_ratings = params[:ratings] || session[:ratings] || {}
    
    if @selected_ratings == {}
      @selected_ratings = Hash[@all_ratings.map {|rating| [rating, rating]}]
    end
    
    if params[:sort] != session[:sort] or params[:ratings] != session[:ratings]
      session[:sort] = sort
      session[:ratings] = @selected_ratings
      redirect_to :sort => sort, :ratings => @selected_ratings and return
    end
    @movies = Movie.where(rating: @selected_ratings.keys).order(ordering)
  end

  def new
    puts 'Exercising "new" path'
    # default: render 'new' template
  end

  def create
    puts 'Exercising "create" path'
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    #puts 'Exercising "edit" path'
    @movie = Movie.find params[:id]
  end

  def update
    #puts 'Exercising "update" path'
    @movie = Movie.find params[:id]
    movie_params['director'] = nil if movie_params['director'] == ''
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    puts 'Exercising "destroy" path'
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  def similar
    puts 'Exercising "similar" path'
    templar = Movie.find params[:id]
    @director = templar[:director]
    @movies = Movie.all.select {|x| x[:director] == @director}
    if 2 > @movies.length
      flash[:notice] = "'#{templar[:title]}' has no director info"
      redirect_to movies_path
    end
  end
end
