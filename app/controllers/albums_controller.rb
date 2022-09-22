class AlbumsController < ApplicationController
  before_action :set_album, only: %i[edit update destroy]

  def index
    @albums = policy_scope(Album)
    # raise
  end

  def new
    @album = Album.new
    authorize @album
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
end
