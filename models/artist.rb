require_relative('../db/sql_runner')

class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end


  def save()
    sql = "INSERT INTO artists (name) VALUES ($1) RETURNING id"
    values = [@name]
    results = SqlRunner.run(sql, values)
    @id = results[0]['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.list()
    sql = "SELECT * FROM artists"
    results = SqlRunner.run(sql)
    return results.map {|artist| Artist.new(artist)}
  end

  def self.list_albums_by_artist(artist_id)
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [artist_id]
    results = SqlRunner.run(sql, values)
    return results.map {|album| Album.new(album)}
  end

end
