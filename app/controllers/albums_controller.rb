class AlbumsController < ApplicationController
  before_action :set_album, only: %i[edit update destroy]

  def index
    if params[:query].present?
      @albums = policy_scope(Album.global_search(params[:query]))
    else
      @albums = policy_scope(Album)
    end
    # raise
  end

  def new
    @album = Album.new
    authorize @album
    @artists = fetch_artist_api
  end

  def create
    @album = Album.new(album_params)
    @album.user = current_user
    authorize @album
    # raise
    if @album.save
      redirect_to albums_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @album.update(album_params)
      redirect_to albums_path
    else
      render :edit
    end
  end

  # def destroy
  #   @album.destroy
  #   redirect_to albums_path
  # end

  def destroy
    if @album.destroy
      flash[:success] = 'Object was successfully deleted.'
      redirect_to albums_url
    else
      flash[:error] = 'Something went wrong'
      redirect_to albums_url
    end
  end

  private

  def set_album
    @album = Album.find(params[:id])
    authorize @album
  end

  def album_params
    params.require(:album).permit(:album_name, :artist, :year, :photo)
  end

  def fetch_artist_api
    response = HTTParty.get('https://europe-west1-madesimplegroup-151616.cloudfunctions.net/artists-api-controller',
                            headers: { Authorization: 'Basic ZGV2ZWxvcGVyOlpHVjJaV3h2Y0dWeQ==' })
    body = JSON.parse(response.body)
    body['json'].map { |artist| artist.first['name'] }
  end
end
