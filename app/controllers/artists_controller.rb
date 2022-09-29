class ArtistsController < ApplicationController
  skip_after_action :verify_policy_scoped, only: :index

  def index
    @artists = fetch_artist_api
    # skip_authorization
  end

  private

  def fetch_artist_api
    response = HTTParty.get('https://europe-west1-madesimplegroup-151616.cloudfunctions.net/artists-api-controller',
                            headers: { Authorization: 'Basic ZGV2ZWxvcGVyOlpHVjJaV3h2Y0dWeQ==' })
    body = JSON.parse(response.body)
    body['json'].map { |artist| artist.first }
  end
end
