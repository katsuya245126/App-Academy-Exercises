class Artist < ApplicationRecord
  has_many :albums,
    class_name: 'Album',
    foreign_key: :artist_id,
    primary_key: :id

  def n_plus_one_tracks
    albums = self.albums
    tracks_count = {}
    albums.each do |album|
      tracks_count[album.title] = album.tracks.length
    end

    tracks_count
  end

  def better_tracks_query
    # TODO: your code here
    artist_tracks =
      albums
        .includes(:tracks)
        .select(:title, 'COUNT(*) AS track_count')
        .group(:title)

    tracks_count = {}

    artist_tracks.each do |album|
      tracks_count[album.title] = album.track_count
    end

    tracks_count
  end
end
