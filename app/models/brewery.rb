class Brewery < ActiveRecord::Base
	  
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  #validates :year, numericality: { greater_than_or_equal_to: 1042,
  #                                  less_than_or_equal_to: 2014,
  #                                  only_integer: true }

  validate :validate_year #käytetään omaa validoijaa

  def validate_year
    if year.blank?
      errors.add(:year, "can't be blank")
    end
    if year.present? && year > Time.now.year
      errors.add(:year, "can't be in the future")
    end
    if year.present? && year < 1042
      errors.add(:year, "can't be less than 1042")
    end
  end


    def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
    puts "number of ratings #{ratings.count}"
  end
  
  def restart
    self.year = 2014
    puts "changed year to #{year}"
  end

end
