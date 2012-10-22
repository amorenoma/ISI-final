# app/controllers/movies_controller.rb  
class MoviesController < ApplicationController
  def show
    if (Movie.find_by_id(params[:id]) == nil) then
      flash[:notice] = "La pelicula solicitada #{params[:id]} no existe."
      redirect_to movies_path     
    else
      @movie = Movie.find(params[:id])
    end
  end

  def index
    @movies = Movie.all

  end

  def create
    if params[:commit] == 'Cancel' then
      redirect_to movies_path
    else
      @movie = Movie.create!(params[:movie])
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movie_path(@movie)
    end
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  def update
    if params[:commit] == 'Cancel' then
      redirect_to movies_path
    else
      @movie = Movie.find params[:id]
      @movie.update_attributes!(params[:movie])
      respond_to do |client_wants|
        client_wants.html do
          flash[:notice] = "#{@movie.title} was successfully updated."
          redirect_to movie_path(@movie)  
        end
        client_wants.xml  {  render :xml => @movie.to_xml    }
      end
    end
end

end
