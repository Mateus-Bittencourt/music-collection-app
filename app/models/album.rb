class Album < ApplicationRecord
  belongs_to :user

  validates :artist, :album_name, presence: true
end
