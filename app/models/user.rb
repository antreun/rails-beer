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

end
