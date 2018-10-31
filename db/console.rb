require_relative('./sql_runner')
require_relative('../models/album')
require_relative('../models/artist')

Album.delete_all()
Artist.delete_all()


artist1 = Artist.new('name' => 'Metallica')

artist1.save
artist1.save

album1 = Album.new('title' => 'St Anger', 'genre' => 'metal', 'artist_id' => artist1.id)

album1.save
# random = Artist.list()
#
# p random

random1 = Album.list_all_by_artist('Metallica')

p random1
