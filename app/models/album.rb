class Album < ApplicationRecord
  belongs_to :user

  validates :artist, :album_name, presence: true

  has_one_attached :photo

  include PgSearch::Model

  pg_search_scope :global_search,
                  against: %i[album_name artist year],
                  using: {
                    tsearch: { prefix: true }
                  }
end
