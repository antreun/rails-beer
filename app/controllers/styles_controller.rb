class StylesController < ApplicationController
  before_action :ensure_that_signed_in, except: [:index, :show]
  before_action :set_style, only: [:show]
  
  def index
  	@styles = Style.all
  end

  def show
    #@style = Style.find_by :id => @style.id
    @style_beers = Beer.where(:style_id => @style.id)
    
end

    def set_style
     @style = Style.find(params[:id])
    
    end

end
