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

b = b1.beers.create name:"Iso 3", style_id:2
r = b.ratings.create score:10
u.ratings << r
r = b.ratings.create score:13
u2.ratings << r

b = b1.beers.create name:"Karhu", style_id:2
r = b.ratings.create score:12
u.ratings << r
r = b.ratings.create score:14
u2.ratings << r

b = b1.beers.create name:"Tuplahumala", style_id:2
r = b.ratings.create score:15
u.ratings << r
r = b.ratings.create score:17
u2.ratings << r

b = b2.beers.create name:"Huvila Pale Ale", style_id:3
r = b.ratings.create score:11
u.ratings << r


b = b2.beers.create name:"X Porter", style_id:4
r = b.ratings.create score:19
u.ratings << r
r = b.ratings.create score:16
u2.ratings << r

b = b3.beers.create name:"Hefezeizen", style_id:5
r = b.ratings.create score:17
u.ratings << r
r = b.ratings.create score:23
u2.ratings << r

b = b3.beers.create name:"Helles", style_id:2

r = b.ratings.create score:18
u2.ratings << r

c = BeerClub.create name:"Kaljaveikot", founded:1999, city:"Turku"
c2 = BeerClub.create name:"Oluen ystävät", founded:2003, city:"Helsinki"
c3 = BeerClub.create name:"Mallas ry.", founded:1987, city:"Tampere"

u.beer_clubs << c
u.beer_clubs << c3
u2.beer_clubs << c2
u2.beer_clubs << c3

#Settings.beermapping_apikey = "71b805e235889c824b7aeb51f38045d3"

s1 = Style.create name:"Ale", description: "This category of beer uses yeast that ferments at the 'top' of the fermentation vessel, and typically at higher temperatures than lager yeast (60°-75°F), which, as a result, makes for a quicker fermentation period (7-8 days, or even less). Ale yeast are known to produce by-products called esters, which are 'flowery' and 'fruity' aromas ranging, but not limited to apple, pear, pineapple, grass, hay, plum, and prune."
s2 = Style.create name:"Lager", description: "The word lager comes from the German word lagern which means, 'to store'. A perfect description as lagers are brewed with bottom fermenting yeast that work slowly at around 34 degrees F, and are often further stored at cool temperature to mature. Lager yeast produce fewer by-product characters than ale yeast which allows for other flavors to pull through, such as hops."
s3 = Style.create name:"English India Pale Ale (IPA)", description: "First brewed in England and exported for the British troops in India during the late 1700s. To withstand the voyage, IPA's were basically tweaked Pale Ales that were, in comparison, much more malty, boasted a higher alcohol content and were well-hopped, as hops are a natural preservative. Historians believe that an IPA was then watered down for the troops, while officers and the elite would savor the beer at full strength. The English IPA has a lower alcohol due to taxation over the decades. The leaner the brew the less amount of malt there is and less need for a strong hop presence which would easily put the brew out of balance. Some brewers have tried to recreate the origianl IPA with strengths close to 8-9% abv."
s4 = Style.create name:"English Porter", description: "Porter is said to have been popular with transportation workers of Central London, hence the name. Most traditional British brewing documentation from the 1700s state that Porter was a blend of three different styles: an old ale (stale or soured), a new ale (brown or pale ale) and a weak one (mild ale), with various combinations of blending and staleness. The end result was also commonly known as 'Entire Butt' or 'Three Threads' and had a pleasing taste of neither new nor old. It was the first truly engineered beer, catering to the public's taste, playing a critical role in quenching the thirst of the UKs Industrial Revolution and lending an arm in building the mega-breweries of today. Porter saw a comeback during the homebrewing and micro-brewery revolution of the late 1970s and early 80s, in the US. Modern-day Porters are typically brewed using a pale malt base with the addition of black malt, crystal, chocolate or smoked brown malt. The addition of roasted malt is uncommon, but used occasionally. Some brewers will also age their beers after inoculation with live bacteria to create an authentic taste. Hop bitterness is moderate on the whole and color ranges from brown to black. Overall they remain very complex and interesting beers."
s5 = Style.create name:"Hefeweizen", description: "A south German style of wheat beer (weissbier) made with a typical ratio of 50:50, or even higher, wheat. A yeast that produces a unique phenolic flavors of banana and cloves with an often dry and tart edge, some spiciness, bubblegum or notes of apples. Little hop bitterness, and a moderate level of alcohol. The 'Hefe' prefix means 'with yeast', hence the beers unfiltered and cloudy appearance. Poured into a traditional Weizen glass, the Hefeweizen can be one sexy looking beer. Often served with a lemon wedge (popularized by Americans), to either cut the wheat or yeast edge, which many either find to be a flavorful snap ... or an insult and something that damages the beer's taste and head retention."

