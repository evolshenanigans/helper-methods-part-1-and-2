class MoviesController < ApplicationController
  def new
    @movie = Movie.new

    render template: "movies/new"
  end

  def index
    # matching_movies = Movie.all

    # @list_of_movies = matching_movies.order({ :created_at => :desc })
    @movies = Movie.order(created_at: :desc)

    respond_to do |format|
      format.json do
        render json: @movies
      end

      format.html
        # render template: "movies/index" 
    end
  end

  def show
    # the_id = params.fetch(:id)

    # matching_movies = Movie.where( id: the_id)

    # @the_movie = matching_movies.first

    # render template:"movies/show"

    #pro
    # @the_movie = Movie.where(id: params.fetch(:id)).first

    #pro2
    # @the_movie = Movie.find_by(id: params.fetch(:id))
    #ultimate
    @movie = Movie.find(params.fetch(:id))
  end

  def create
    @movie = Movie.new
    @movie.title = params.fetch(:title)
    @movie.description = params.fetch(:description)

    if @movie.valid?
      @movie.save
      redirect_to(movies_url, { notice: "Movie created successfully." })
    else
      render template: "movies/new"
    end
  end

  def edit
    the_id = params.fetch(:id)

    matching_movies = Movie.where(id: the_id)

    @movie = matching_movies.first

    render template: "movies/edit"
  end

  def update
    the_id = params.fetch(:id)
    the_movie = Movie.where(id: the_id).first

    the_movie.title = params.fetch("query_title")
    the_movie.description = params.fetch("query_description")

    if the_movie.valid?
      the_movie.save
      redirect_to(movie_url(the_movie.id), { notice: "Movie updated successfully."} )
    else
      redirect_to(movie_url(the_movie.id), { alert: "Movie failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch(:id)
    the_movie = Movie.where( id: the_id).first

    the_movie.destroy

    redirect_to(movies_url, { notice: "Movie deleted successfully."} )
  end
end
