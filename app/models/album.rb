class Album < ApplicationRecord
  belongs_to :user

  validates :artist, :album_name, presence: true

  has_one_attached :photo
end
