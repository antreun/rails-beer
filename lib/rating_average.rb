module RatingAverage

  def average_rating
	if ratings.empty?
 		"no ratings"
	else
		# inject
		#ratings.inject(0.0) { |sum, rating| sum + rating.score } / ratings.count

		# ActiveRecord
		ratings.average("score")

		# vanha tapa
		#@score = 0.0	# desimaalit mukaan!
 		#ratings.each do |rating|
   		#	@score = @score + rating.score
   		#end
   		#@score = @score / ratings.count
 		##{@score}"
	end
  end

end
