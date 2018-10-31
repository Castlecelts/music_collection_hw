require_relative('./artist')
require_relative('../db/sql_runner')

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

  def self.list_all_by_artist(artist_id)
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [artist_id]
    results = SqlRunner.run(sql, values)
    return results.map {|album| Album.new(album)}
  end



end
