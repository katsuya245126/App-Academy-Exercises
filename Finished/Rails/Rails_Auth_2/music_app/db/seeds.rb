# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(email: 'admin', password: 'password', admin: true, activated: true)
User.create!(email: 'user', password: 'password', activated: true)

slipknot = Band.create(name: 'Slipknot')
aerosmith = Band.create(name: 'Aerosmith')
beatles = Band.create(name: 'The Beatles')
led_zeppelin = Band.create(name: 'Led Zeppelin')

hope = Album.create!(band_id: slipknot.id, title: 'All Hope is Gone', year: 2008, live: false)
Track.create!(album_id: hope.id, title: '.execute.', ord: 1)
Track.create!(album_id: hope.id, title: 'Gematria', ord: 2)
Track.create!(album_id: hope.id, title: 'Sulfur', ord: 3)
Track.create!(album_id: hope.id, title: 'Psychosocial', ord: 4)
Track.create!(album_id: hope.id, title: 'Dead Memories', ord: 5)

kind = Album.create!(band_id: slipknot.id, title: 'We Are Not Your Kind', year: 2019, live: false)
Track.create!(album_id: kind.id, title: 'Insert Coin', ord: 1)
Track.create!(album_id: kind.id, title: 'Unsainted', ord: 2)
Track.create!(album_id: kind.id, title: 'Birth Of The Cruel', ord: 3)
Track.create!(album_id: kind.id, title: 'Death Because of Death', ord: 4)
Track.create!(album_id: kind.id, title: 'Nero Forte', ord: 5)

grip = Album.create!(band_id: aerosmith.id, title: 'Get a Grip', year: 1993, live: false)
Track.create!(album_id: grip.id, title: 'Intro', ord: 1)
Track.create!(album_id: grip.id, title: 'Eat the Rich', ord: 2)
Track.create!(album_id: grip.id, title: 'Get a Grip', ord: 3)
Track.create!(album_id: grip.id, title: 'Fever', ord: 4)
Track.create!(album_id: grip.id, title: 'Livin\' on the edge', ord: 5)

toys = Album.create!(band_id: aerosmith.id, title: 'Toys in the Attic', year: 1975, live: false)
Track.create!(album_id: toys.id, title: 'Toys in the Attic', ord: 1)
Track.create!(album_id: toys.id, title: 'Uncle Salty', ord: 2)
Track.create!(album_id: toys.id, title: 'Adam\'s Apple', ord: 3)
Track.create!(album_id: toys.id, title: 'Walk This Way', ord: 4)
Track.create!(album_id: toys.id, title: 'Big Ten Inch Record', ord: 5)

road = Album.create!(band_id: beatles.id, title: 'Abbey Road', year: 1969, live: false)
Track.create!(album_id: road.id, title: 'Come Together', ord: 1)
Track.create!(album_id: road.id, title: 'Something', ord: 2)
Track.create!(album_id: road.id, title: 'Maxwell\'s Silver Hammer', ord: 3)
Track.create!(album_id: road.id, title: 'Oh! Darling', ord: 4)
Track.create!(album_id: road.id, title: 'Octopus\'s Garden', ord: 5)

let = Album.create!(band_id: beatles.id, title: 'Let It Be', year: 1970, live: false)
Track.create!(album_id: let.id, title: 'Two Of Us', ord: 1)
Track.create!(album_id: let.id, title: 'Dig A Pony', ord: 2)
Track.create!(album_id: let.id, title: 'Across The Universe', ord: 3)
Track.create!(album_id: let.id, title: 'I Me Mine', ord: 4)
Track.create!(album_id: let.id, title: 'Dig It', ord: 5)

led = Album.create!(band_id: led_zeppelin.id, title: 'Led Zeppelin IV', year: 1971, live: false)
Track.create!(album_id: led.id, title: 'Black Dog', ord: 1)
Track.create!(album_id: led.id, title: 'Rock and Roll', ord: 2)
Track.create!(album_id: led.id, title: 'The Battle of Evermore', ord: 3)
Track.create!(album_id: led.id, title: 'Stairway to Heaven', ord: 4)
Track.create!(album_id: led.id, title: 'Misty Mountain Hop', ord: 5)

coda = Album.create!(band_id: led_zeppelin.id, title: 'Coda', year: 1982, live: false)
Track.create!(album_id: coda.id, title: 'We\'re Gonna Groove', ord: 1)
Track.create!(album_id: coda.id, title: 'Poor Tom', ord: 2)
Track.create!(album_id: coda.id, title: 'I Can\'t Quit You Baby', ord: 3)
Track.create!(album_id: coda.id, title: 'Walter\'s Walk', ord: 4)
Track.create!(album_id: coda.id, title: 'Ozone Baby', ord: 5)