require_relative('./artist')
require_relative('../db/sql_runner')
require('pry')

class Album

  attr_reader :id
  attr_accessor :title, :genre, :artist_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save
    sql = "INSERT INTO albums (title, genre, artist_id) VALUES ($1, $2, $3) RETURNING id"
    values = [@title, @genre, @artist_id]
    results = SqlRunner.run(sql, values)
    @id = results[0]['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.list()
    sql = "SELECT * FROM albums"
    results = SqlRunner.run(sql)
    return results.map {|album| Album.new(album)}
  end

  def list_artist_of_album()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@customer_id]
    results = SqlRunner.run(sql, values)
    # binding.pry
    artist_hash = results.first
    artist = Artist.new(artist_hash)
    return artist
  end



end
