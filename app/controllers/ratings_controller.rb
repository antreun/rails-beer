class RatingsController < ApplicationController
  before_action :ensure_that_signed_in, except: [:index, :show]
  
  def index
  	@ratings = Rating.all
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

 def create
 	#byebug
    #Rating.create params[:rating]
    @rating = Rating.create params.require(:rating).permit(:score, :beer_id)

    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end

  end

 def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    #redirect_to ratings_path
    redirect_to :back
  end
  
end
