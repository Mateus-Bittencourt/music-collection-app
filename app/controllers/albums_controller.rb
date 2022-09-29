class AlbumsController < ApplicationController
  before_action :set_album, only: %i[edit update destroy]

  def index
    if params[:artist_id].present?
      @albums = search_by_artist
    elsif params[:query].present?

      @albums = policy_scope(Album.global_search(params[:query]))
    else
      @albums = policy_scope(Album)
    end
  end

  def new
    @album = Album.new
    authorize @album
    @artists = fetch_artist_api.map { |artist| artist.first['name'] }
  end

  def create
    @album = Album.new(album_params)
    @album.user = current_user
    authorize @album
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

  def destroy
    if @album.destroy
      redirect_to albums_url, notice: 'Album was successfully destroyed.'
    else
      redirect_to albums_url, alert: 'Album was not destroyed. Please try again.'
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
    body['json']
  end

  def search_by_artist
    artists = fetch_artist_api
    @artist = artists.select { |artist| artist.first['id'] == params[:artist_id].to_i }.first.first
    if params[:query].present?
      policy_scope(Album.global_search(params[:query])).where(artist: @artist['name'])
    else
      policy_scope(Album).where(artist: @artist['name'])
    end
  end
end
