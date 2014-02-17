class Style < ActiveRecord::Base

	belongs_to :beer

  	validates :name, presence: true
    validates :description, presence: true


  def to_s
  		"#{name}"
  end

end
