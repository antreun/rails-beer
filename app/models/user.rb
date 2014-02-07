class User < ActiveRecord::Base

  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 15 }

  validates :password, length: { minimum: 4 }

  validates :password, format: 
  { 
  	with: /[A-Z].*\d|\d.*[A-Z]/,
  	message: "requires at least one digit and one uppercase character"
  }

  has_many :ratings,  dependent: :destroy # käyttäjällä on monta ratingia
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return nil if ratings.empty?   # palautetaan nil jos reittauksia ei ole
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    # tämä ei varmasti ole mikään optimaalisin ratkaisu, mutta toimii!
    return nil if ratings.empty?  
    styles = Hash.new
    count = Hash.new
    ratings.each do |rating|
      if styles[rating.beer.style].nil?
        styles[rating.beer.style] = rating.score
        count[rating.beer.style] = 1
      else
        styles[rating.beer.style] += rating.score
        count[rating.beer.style] += 1
      end
    end
    count.each do |c|
      styles[c.first] /=  count[c.first]
    end
    return styles.max_by{|k,v| v}.first

  end

  def favorite_brewery
    return nil if ratings.empty?  
    averages = Hash.new
    b = Brewery.all
    b.each do |brewery|
      if not brewery.user_ratings(self).nil?
        averages[brewery] = brewery.user_ratings(self)
      end
    end
    return averages.max_by{|k,v| v}.first
  end
end
