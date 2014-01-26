class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def average_rating
	if ratings.empty?
 		"no ratings"
	else
		# inject
		#ratings.inject(0.0) { |sum, rating| sum + rating.score } / ratings.count

		# ActiveRecord
		#ratings.average("score")

		# vanha tapa
		#@score = 0.0	# desimaalit mukaan!
 		#ratings.each do |rating|
   		#	@score = @score + rating.score
   		#end
   		#@score = @score / ratings.count
 		##{@score}"
	end
  end

  def to_s
  		"#{name} (#{brewery.name})"
  end


end
