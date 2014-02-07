# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


u = User.create username:"Antti", password:"123QWE", password_confirmation:"123QWE"
u2 = User.create username:"Testi", password:"123QWE", password_confirmation:"123QWE"

b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1042

b = b1.beers.create name:"Iso 3", style:"Lager"
r = b.ratings.create score:10
u.ratings << r
r = b.ratings.create score:13
u2.ratings << r

b = b1.beers.create name:"Karhu", style:"Lager"
r = b.ratings.create score:12
u.ratings << r
r = b.ratings.create score:14
u2.ratings << r

b = b1.beers.create name:"Tuplahumala", style:"Lager"
r = b.ratings.create score:15
u.ratings << r
r = b.ratings.create score:17
u2.ratings << r

b = b2.beers.create name:"Huvila Pale Ale", style:"Pale Ale"
r = b.ratings.create score:11
u.ratings << r


b = b2.beers.create name:"X Porter", style:"Porter"
r = b.ratings.create score:19
u.ratings << r
r = b.ratings.create score:16
u2.ratings << r

b = b3.beers.create name:"Hefezeizen", style:"Weizen"
r = b.ratings.create score:17
u.ratings << r
r = b.ratings.create score:23
u2.ratings << r

b = b3.beers.create name:"Helles", style:"Lager"

r = b.ratings.create score:18
u2.ratings << r

c = BeerClub.create name:"Kaljaveikot", founded:1999, city:"Turku"
c2 = BeerClub.create name:"Oluen ystävät", founded:2003, city:"Helsinki"
c3 = BeerClub.create name:"Mallas ry.", founded:1987, city:"Tampere"

u.beer_clubs << c
u.beer_clubs << c3
u2.beer_clubs << c2
u2.beer_clubs << c3
