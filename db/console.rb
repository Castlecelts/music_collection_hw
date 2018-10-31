require_relative('./sql_runner')
require_relative('../models/album')
require_relative('../models/artist')

artist1 = Artist.new('name' => 'Metallica')

artist1.save
