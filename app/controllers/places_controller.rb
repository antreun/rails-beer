class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    # talletetaan haun tulokset sessioon
    session[:beermapping_city] = params[:city]
    
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  def show
    @city = session[:beermapping_city]
    @places = BeermappingApi.place(params[:id])
    @place = @places.first
    render :show
  end
end
