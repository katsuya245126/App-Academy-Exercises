# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

pablo = User.create!(username: 'Pablo Picasso')
michel = User.create!(username: 'Michelangelo')
vincent = User.create!(username: 'Vincent van Gogh')

a = Artwork.create!(title: 'Guernica', image_url: 'guernica.com', artist_id: pablo.id, favorite: true)
b = Artwork.create!(title: 'The Weeping Woman', image_url: 'theweepingwoman.com', artist_id: pablo.id)
c = Artwork.create!(title: 'La Vie', image_url: 'lavie.com', artist_id: pablo.id)

d = Artwork.create!(title: 'The Creation of Adam', image_url: 'thecreationofadam.com', artist_id: michel.id, favorite: true)
e = Artwork.create!(title: 'The Last Judgement', image_url: 'thelastjudgement.com', artist_id: michel.id)
f = Artwork.create!(title: 'David of Michelangelo', image_url: 'davidofmichelangelo.com', artist_id: michel.id)

g = Artwork.create!(title: 'The Starry Night', image_url: 'thestarrynight.com', artist_id: vincent.id, favorite: true)
h = Artwork.create!(title: 'Irises', image_url: 'irises.com', artist_id: vincent.id)
i = Artwork.create!(title: 'The Bedroom', image_url: 'thebedroom.com', artist_id: vincent.id)

ArtworkShare.create!(artwork_id: a.id, viewer_id: michel.id, favorite: true)
ArtworkShare.create!(artwork_id: a.id, viewer_id: vincent.id)

ArtworkShare.create!(artwork_id: b.id, viewer_id: michel.id)

ArtworkShare.create!(artwork_id: d.id, viewer_id: pablo.id)
ArtworkShare.create!(artwork_id: d.id, viewer_id: vincent.id, favorite: true)

ArtworkShare.create!(artwork_id: e.id, viewer_id: vincent.id)

ArtworkShare.create!(artwork_id: g.id, viewer_id: michel.id)
ArtworkShare.create!(artwork_id: g.id, viewer_id: pablo.id, favorite: true)

ArtworkShare.create!(artwork_id: h.id, viewer_id: pablo.id)

Comment.create!(user_id: pablo.id, artwork_id: d.id, body: 'Excellent - by pablo')
Comment.create!(user_id: pablo.id, artwork_id: g.id, body: 'Fantastic - by pablo')

Comment.create!(user_id: michel.id, artwork_id: b.id, body: 'Remarkable - by michelangelo')
Comment.create!(user_id: michel.id, artwork_id: h.id, body: 'Superb - by michelangelo')

Comment.create!(user_id: vincent.id, artwork_id: c.id, body: 'Impressive - by vincent')
Comment.create!(user_id: vincent.id, artwork_id: f.id, body: 'Magnificent - by vincent')

first = Collection.create!(name: 'First', user_id: pablo.id)
second = Collection.create!(name: 'Second', user_id: michel.id)
third = Collection.create!(name: 'Third', user_id: vincent.id)

ArtworkCollection.create!(collection_id: first.id, artwork_id: a.id)
ArtworkCollection.create!(collection_id: first.id, artwork_id: d.id)
ArtworkCollection.create!(collection_id: first.id, artwork_id: g.id)

ArtworkCollection.create!(collection_id: second.id, artwork_id: b.id)
ArtworkCollection.create!(collection_id: second.id, artwork_id: e.id)
ArtworkCollection.create!(collection_id: second.id, artwork_id: h.id)

ArtworkCollection.create!(collection_id: third.id, artwork_id: c.id)
ArtworkCollection.create!(collection_id: third.id, artwork_id: f.id)
ArtworkCollection.create!(collection_id: third.id, artwork_id: i.id)
